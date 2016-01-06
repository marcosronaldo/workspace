git checkout db/schema.rb
./script/noosfero-plugins disableall
rake db:drop
rake db:create
rake db:schema:load
rake db:migrate

rake db:data:minimal

./script/noosfero-plugins enable organization_ratings
rake db:migrate

./script/noosfero-plugins enable software_communities
rake db:migrate

./script/noosfero-plugins enable gov_user
rake db:migrate

rails c <<EOF
  user = User.create(:login => "adminuser", :email => "adminuser@admin.com", :password => "admin", :password_confirmation => "admin")
  user.activate

  environment = Environment.default
  environment.add_admin user.person

  environment.enable_plugin('OrganizationRatingsPlugin')
  environment.enable_plugin('SoftwareCommunitiesPlugin')
  environment.enable_plugin('GovUserPlugin')

  environment.theme = 'noosfero-spb-theme'
  environment.save
  exit
EOF
