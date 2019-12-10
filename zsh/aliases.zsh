# dir
alias cdcode='cd ~/code/'
alias cdwork='cd ~/code/work/'
alias cddot='cd ~/.dotfiles/'
alias cdgo='cd ~/code/tx/goprojects/src/'
#alias cdzhe='cd ~/code/work/tao800_fire'
alias cdnode='cd ~/code/node'
alias cdjava='cd ~/code/java'
alias cdblog='cd ~/code/zhongfox.github.io'
alias cdd='cd ~/Downloads'
#alias cdbook='cd ~/Documents/book'
alias cdff='cd ~/Library/Application\ Support/Firefox/Profiles/iwn5v7ri.default/extensions'
alias cdn='cd /usr/local/etc/nginx'
#alias cdkoa='cd /Users/zhonghua/code/work/cd-ruby-common_package_source/node/koa800'
alias cdtx='cd /Users/zhonghua/code/tx'
alias cdflow='cd /Users/zhonghua/code/tx/workflow'
alias cdi='/Users/zhonghua/code/tx/istio.io/istio'
alias cdm='cd /Users/zhonghua/code/tx/mesh-manager'
alias cddemo='cd /Users/zhonghua/code/tx/tcm-demo'

alias kc='kubectl'
alias kci='kubectl -nistio-system'
alias huawei='KUBECONFIG=/Users/zhonghua/.kube/huaweiconfig.json kubectl --context external'
alias gz='kubectl --context guangzhou'
alias gzi='kubectl --context guangzhou -n istio-system'
alias puml='/Users/zhonghua/.gvm/pkgsets/go1.11/global/src/git.oschina.net/jscode/go-package-plantuml/go-package-plantuml'

alias tkes='/Users/zhonghua/code/tx/goprojects/src/git.code.oa.com/tke/tke/output/darwin/amd64/tke-apiserver \
--log-level=info \
--log-output-paths=tke-apiserver.log \
--bind-port=9443 \
--tls-cert-file=/usr/local/var/lib/tke/certs/tke-apiserver-local/tke-apiserver.pem \
--tls-private-key-file=/usr/local/var/lib/tke/certs/tke-apiserver-local/tke-apiserver-key.pem \
--etcd-servers=http://127.0.0.1:2379 \
--etcd-prefix=/tke_local \
--requestheader-client-ca-file=/usr/local/var/lib/tke/certs/tke-apiserver-local/ca-proxy.pem \
--requestheader-username-headers=X-Remote-User \
--requestheader-tenantid-headers=X-Remote-TenantID \
--requestheader-extra-headers-prefix=X-Remote-Extra-'


#alias for cnpm
# alias cnpm="npm --registry=https://registry.npm.taobao.org \
#   --cache=$HOME/.npm/.cache/cnpm \
#   --disturl=https://npm.taobao.org/dist \
#   --userconfig=$HOME/.cnpmrc"

# alias lnpm="npm --registry=http://localhost:4873 \
#   --cache=$HOME/.npm/.cache/lnpm \
#   --userconfig=$HOME/.lnpmrc"
# alias tnpm="npm --registry=http://npm.tuan800-inc.com \
#   --cache=$HOME/.npm/.cache/tnpm \
#   --userconfig=$HOME/.tnpmrc"

#alias p="export http_proxy=web-proxy.tencent.com:8080;export https_proxy=web-proxy.tencent.com:8080;export npm_config_proxy=http://web-proxy.tencent.com:8080"
# alias p="export http_proxy=dev-proxy.oa.com:8080;export https_proxy=dev-proxy.oa.com:8080;export npm_config_proxy=http://dev-proxy.oa.com:8080"
# alias np="unset http_proxy;unset https_proxy;unset npm_config_proxy"

export no_proxy=localhost,127.0.0.1,.oa.com,.qq.com,.tencent.com

is_tx_on() {
  autoproxyurl=`networksetup -getautoproxyurl "Wi-Fi"`
  if [[ $autoproxyurl = *Enabled:\ Yes* ]]
  then
    return 0 # 0 is true
  fi
  return 1  # 1 is false
}

is_fq_on () {
  socksfirewallproxy=`networksetup -getsocksfirewallproxy "Wi-Fi"`
  if [[ $socksfirewallproxy = *Enabled:\ Yes* ]]
  then
    return 0 # 0 is true
  fi
  return 1  # 1 is false
}

np () {
  if is_fq_on
  then
    launchctl unload /Library/LaunchDaemons/com.shadowsocks.plist
    networksetup -setsocksfirewallproxystate "Wi-Fi" off
    echo "HK Proxy off"
  fi

  if is_tx_on
  then
    unset http_proxy
    unset https_proxy
    unset npm_config_proxy
    unset ALL_PROXY
    [ -e ~/.ssh/config.d/proxy ] && rm ~/.ssh/config.d/proxy
    networksetup -setautoproxystate "Wi-Fi" off
    echo "Tencent Proxy off"
  fi
}

set_tx_proxy_env () {
  proxy='web-proxy.tencent.com:8080'
  export http_proxy=$proxy
  export https_proxy=$proxy
  export npm_config_proxy='http://dev-proxy.oa.com:8080'
}

tp () {
  if is_tx_on
  then
    echo "Tencent Proxy already on"
  else
    np
    ln -s ~/.ssh/config.d/tencent_proxy ~/.ssh/config.d/proxy
    networksetup -setautoproxyurl "Wi-Fi" "http://txp-01.tencent.com/proxy_ngn.pac?pc=FOXZHONG%2DMB1&ip=192.168.101.8&ver=5.0.13.110"
    #alias ab='ab -X dev-proxy.oa.com:8080'
    echo "Tencent Proxy on"
  fi
}

fq () {
  if is_fq_on
  then
    echo "HK Proxy already on"
  else
    np
    launchctl load /Library/LaunchDaemons/com.shadowsocks.plist
    networksetup -setsocksfirewallproxy "Wi-Fi" localhost 1080
    echo "HK Proxy on"
  fi
}

if is_tx_on
then
  set_tx_proxy_env
fi
