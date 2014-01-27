Event
====

## Installation

    $ git clone https://github.com/felipeconti/Event
    $ cd Event
    $ bundle
    $ cp config/exemple.database.yml config/database.yml
    $ cp config/exemple.sync.yml config/sync.yml
    $ cp exemple.env.development .env.development
    $ rake db:create
    $ rake db:migrate
    $ rake db:seed
