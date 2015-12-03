mkdir ~/git
cd ~/git
[[ -d softwarepublico ]] || git -c http.sslVerify=false clone http://softwarepublico.gov.br/gitlab/softwarepublico/softwarepublico.git
[[ -d noosfero ]] || git clone https://gitlab.com/noosfero/noosfero.git

ln -s softwarepublico/src/noosfero-spb/software_communities noosfero/plugins/
ln -s softwarepublico/src/noosfero-spb/gov_user noosfero/plugins/

ln -s softwarepublico/src/noosfero-spb/noosfero-spb-theme noosfero/public/designs/themes/

git config --global user.name "Marcos Ronaldo"
git config --global user.email marcos.rpj2@gmail.com

./../config/setup_config.sh

