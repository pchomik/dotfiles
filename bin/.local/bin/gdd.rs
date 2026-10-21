// gdd shim: uutils dd (Ubuntu 26.04) blocks on PTYs with iflag=nonblock,
// which stalls fzf-tab's tab-completion until a second keypress.
// See Aloxaf/fzf-tab issue #578. This shim sets O_NONBLOCK properly.

use std::io::Write;
use std::os::fd::AsRawFd;
use std::os::unix::process::CommandExt;
use std::process::Command;

const F_GETFL: i32 = 3;
const F_SETFL: i32 = 4;
const O_NONBLOCK: i32 = 0o4000; // Linux

unsafe extern "C" {
    fn fcntl(fd: i32, cmd: i32, arg: i32) -> i32;
    fn read(fd: i32, buf: *mut u8, n: usize) -> isize;
}

fn main() {
    if !std::env::args().skip(1).any(|a| a.contains("nonblock")) {
        let err = Command::new("/usr/bin/dd")
            .arg0("dd")
            .args(std::env::args_os().skip(1))
            .exec();
        std::process::exit(err.raw_os_error().unwrap_or(127));
    }

    let fd = std::io::stdin().as_raw_fd();
    let old = unsafe { fcntl(fd, F_GETFL, 0) };
    if old < 0 {
        return;
    }
    unsafe { fcntl(fd, F_SETFL, old | O_NONBLOCK) };

    let mut buf = [0u8; 65536];
    let n = unsafe { read(fd, buf.as_mut_ptr(), buf.len()) };
    unsafe { fcntl(fd, F_SETFL, old) };

    if n > 0 {
        let mut out = std::io::stdout().lock();
        let _ = out.write_all(&buf[..n as usize]);
        let _ = out.flush();
    }
}
