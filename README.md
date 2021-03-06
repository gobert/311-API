# 311 API

This is an API that displays the 311-cases of San Francisco. It was a technical test for a company. [Check the original spec](https://github.com/gobert/311-API/tree/8c8c14f76e2b8fc3eada93f95f38d4a45bdc3032).

Usage example:
```
GET /cases.json
# Returns the "latest" 1 000 cases

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
There are around 2,5 million records in the database. So the API never returns all the cases: it limits to the first 1 000 cases (ordered by ascending opened_at)

You can paginate through the API with the parameter ```since``` like:

| Page number | Query                        | First case opened at:  | Last case opened at  (UTC ISO8601) | Lat case opened at (UNIX timestamp) | Notes     |
|-------------|------------------------------|------------------------|------------------------------------|-------------------------------------|-----------|
| 1           | /cases.json                  | "2015-04-29T17:51:16Z" | "2015-04-30T18:24:16Z"             | 1430418256                          | 1st page  |
| 2           | /cases.json?since=1430418256 | "2015-04-30T18:24:16Z" | "2015-05-01T19:46:34Z"             | 1430509594                          |           |
| ...         | ...                          | ....                   | ....                               | ....                                |           |
| n           | /case.json=since=1506516195  | "2017-09-27T12:42:48Z" | "2017-09-27T12:42:48Z"             | 1506516195                          | Last page |

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
  bundle exec rake
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
