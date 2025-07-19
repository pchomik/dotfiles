function load_go() {
    if [ -d "/usr/local/go/bin" ]; then
        export PATH="/usr/local/go/bin:$PATH"
        export PATH=$PATH:$(go env GOPATH)/bin
    fi
}
