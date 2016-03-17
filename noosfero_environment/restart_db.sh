#!/bin/sh
sample_data=false
while getopts "p:d" arg; do
  case $arg in
    p)
      plugins=$OPTARG
      ;;
    d)
      sample_data=true
      ;;
  esac
done

./script/noosfero-plugins disableall
rake db:drop
git checkout db/schema.rb

rm -f config/database.yml

./script/arch-quick-start

./script/noosfero-plugins enable ${plugins//,/ }
rake db:migrate


rails c <<EOF
  user = User.create(:login => "adminuser", :email => "adminuser@admin.com", :password => "admin", :password_confirmation => "admin")
  user.activate

  environment = Environment.default
  environment.add_admin user.person

  environment.theme = 'noosfero-spb-theme'
  environment.save
  exit
EOF

if [ "$sample_data" = true ]; then
	ruby script/sample-data
fi

rake db:test:prepare
