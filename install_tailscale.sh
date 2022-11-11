#!/bin/sh
# this script assumes you are root!
# tailscale uses the hostname of the system to identify the node, make sure it is set the way you want

VERSION=${1}
AUTHKEY=${2}

install -d /usr/local/tailscale

systemctl stop tailscaled

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

rm -f /usr/local/tailscale/tailscaled.defaults
rm -f /etc/systemd/system/tailscaled.service

mv /root/tailscaled.defaults  /usr/local/tailscale/tailscaled.defaults
mv /root/tailscaled.service  /etc/systemd/system/tailscaled.service

if [ ! -f /usr/local/tailscale/tailscaled.state ]; then touch /usr/local/tailscale/tailscaled.state; fi

systemctl daemon-reload
systemctl start tailscaled

tailscale up --auth-key ${AUTHKEY}
