def proxy [] {
    let-env ALL_PROXY = "http://127.0.0.1:7890"
    let-env http_proxy = "http://127.0.0.1:7890"
    let-env https_proxy = "http://127.0.0.1:7890"
    echo $"启动代理：($env.ALL_PROXY)"
}

def noproxy [] {
    hide ALL_PROXY
    hide http_proxy
    hide https_proxy
    echo $"关闭代理 ($env.ALL_PROXY)"
}

def has-env [envname] {
    (env | where name == $envname | length) != 0
}

def-env add-path [envname paths] {
    let newvalue = (
        if (has-env $envname) {($paths | append ($env | get $envname))} 
        else {$paths})
    let-env $envname = $newvalue
}

## CUDA
let-env CUDA_HOME = '/usr/local/cuda-11'
add-path LD_LIBRARY_PATH '/usr/local/cuda/lib64'
add-path PATH '/usr/local/cuda-11/bin'
## CUDA

## tools
add-path PATH $"($env.HOME)/bin"

## rust
let-env RUSTUP_DIST_SERVER = "https://mirrors.tuna.tsinghua.edu.cn/rustup"

## quick cd
def-env cd-github [] {
    cd ~/GitHub
}

def newdir [dirname] {
    mkdir $dirname
    cd $dirname
}