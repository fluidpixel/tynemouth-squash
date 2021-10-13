# README

Booking system for a squash (or any) club that has courts (or tables, or pitches, or lanes) and set time slots for those courts that can be booked.

Bookings can be made by members who login with their last name and membership numbers.

Admins have rights to book courts under any players name, remove and change bookings.

Admins are also able to mark the court as paid/un paid upon collection of payment. 


## Download remote database to local

```
heroku pg:backups capture -a tynemouth-squash
curl -o latest.dump `heroku pg:backups public-url -a tynemouth-squash`
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U [USERNAME] -d [DATABASENAME] latest.dump

rake db:create //to create local database
```
## Deploy

set heroku up as a remote (https://git.heroku.com/tynemouth-squash.git)
heroku git:remote -a tynemouth-squash
push to heroku master branch

## Setting up on fresh Mac install

1. `ruby -v` //check for installation

2. `sudo gem install rails` //install rails globally

3. install postgress: https://www.postgresql.org/download/macosx/ (https://postgresapp.com/documentation/cli-tools.html)

4. `bundle install`

5. install heroku cli:

    `curl https://cli-assets.heroku.com/install.sh | sh`

5. follow backup instructions above

6. rails db:migrate RAILS_ENV=development
5. `rails s`