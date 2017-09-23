# 311 API

This is an API that displays the 311-cases of San Francisco. It was a technical test for a company. [Check the original spec](https://github.com/gobert/311-API/tree/8c8c14f76e2b8fc3eada93f95f38d4a45bdc3032).

Usage example:
```
GET /cases.json
# Returns all cases

GET /cases.json?since=1398465719
# Returns cases opened since UNIX timestamp 1398465719

GET /cases.json?status=open
# Returns cases that are in open state.

GET /cases.json?category=General%20Requests
# Returns cases that belong to "General Requests" category

GET /cases.json?near=37.77,-122.48
# Returns cases that were created within 5 mile radius of lat=37.77 and lng=-122.48

GET /cases.json?near=37.77,-122.48&status=open&category=General%20Requests
# API endpoint should be able to take any combination of GET params.
```

# Set up
* Install ruby 2.3.3. For instance, using rvm: ``` rvm install 2.3.3```
* Install PostgreSQL, for instance, on OS X using homebrew: ```brew install postgresql```
* Install gem bundler: ```gem install bundler --no-ri --no-rdoc```
* Install dependencies: ```bundle install```
* Create Database: ```bundle install```

# Run it
* The first time, create the database: ``` bin/rake db:create ```
* Ensure you run all the migrations: ```bin/rake db:migrate ```
* Import new 311-cases: ```run rake cases:new:import```. Take care the first time it will import all the cases more than 2,5 million!
* Start the webserver: ```bin/rails s```

# Test suite
On top of each commit, all tests must pass:
```
  bundle exec rspec -- spec/
```
# Check code syntax
On top of each commit, no offenses must be detected
```
  bundle exec rubocop -- .
```
# Check security
On top of each commit, you should make a static security analysis with:
```
  bundle exec brakeman
```
