Event
====

To run:

cp config/exemple.database.yml config/database.yml
cp exemple.env.development .env.development

rake db:create
rake db:migrate
rake db:seed

rails s
