# README

Simply fork and follow the below list of steps and should be good to go:

Clone the repo

```
$ git clone https://github.com/chandlerjwang/userapp.git
```

Gemfile

```
$ bundle install --without production
```

Migration

```
$ rails db:migrate
```
Start the server

```ruby
$ rails s
```