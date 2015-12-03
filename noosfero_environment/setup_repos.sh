mkdir ~/git
cd ~/git
git -c http.sslVerify=false clone http://softwarepublico.gov.br/gitlab/softwarepublico/softwarepublico.git
git clone https://gitlab.com/noosfero/noosfero.git

ln -s softwarepublico/src/noosfero-spb/software_communities noosfero/plugins/
ln -s softwarepublico/src/noosfero-spb/gov_user noosfero/plugins/

ln -s softwarepublico/src/noosfero-spb/noosfero-spb-theme noosfero/public/designs/themes/

git config --global user.name "Marcos Ronaldo"
git config --global user.email marcos.rpj2@gmail.com

sh ../config/setup_config.sh
