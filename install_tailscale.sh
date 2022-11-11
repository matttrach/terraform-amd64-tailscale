#!/bin/sh
# this script assumes you are root!
# this assumes you have already copied over the files

VERSION=${1}

install -d /usr/local/tailscale

cat << EOF > /usr/local/tailscale/envrc
export PATH=/usr/local/sbin:/usr/local/bin:$PATH
EOF

. /usr/local/tailscale/envrc

curl -s https://pkgs.tailscale.com/stable/tailscale_${VERSION}.tgz --output tailscale_${VERSION}.tgz
tar -xvf tailscale_${VERSION}.tgz

cp tailscale_${VERSION}/tailscale /usr/local/bin/tailscale
chmod +x /usr/local/bin/tailscale

cp tailscale_${VERSION}/tailscaled /usr/local/bin/tailscaled
chmod +x /usr/local/bin/tailscaled

mv /root/tailscale.defaults /usr/local/tailscale/tailscale.defaults
mv /root/tailscale.service  /etc/systemd/system/tailscale.service
touch /usr/local/tailscale/tailscaled.state

