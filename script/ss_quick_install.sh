
cd ..
cp shadowsocks.json ~/shadowsocks.json
cp etc/systemd/system/ssserver.service /etc/systemd/system/ssserver.service

cd ~/

vim shadowsocks.json

git clone https://github.com/shadowsocks/shadowsocks.git
cd shadowsocks
git checkout master

cd ~/

pip3 install -e shadowsocks

systemctl start ssserver
systemctl status ssserver
