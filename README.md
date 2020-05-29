
Sittme Test Task
-----------

Simple application that allow create posts and get list of them.


System Dependencies
-------------------

- Ruby 2.6.5 (install with [rbenv](https://github.com/sstephenson/rbenv))
- Rails 6.0.2.1
- PostgreSQL

Project Install
-------------------
```shell
git clone git@github.com:omelinb/sittme_test_task.git
bundle install
```

Database creation
-----------------

Create database
```shell
bundle exec rails db:create  
bundle exec rails db:migrate  
```

Run tests
-----------------

```
bundle exec rspec spec
```
