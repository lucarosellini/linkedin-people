Linkedin people search
======================

This automated script searches possible matches(3) of names with their current work.
It relays on watir, so it will use a real browser.
Unfortunately the api has been vetted [1], so this is a really slow alternative to the API.

[1] - (people-api)[https://developer.linkedin.com/documents/people-search-api]

## Installing

```bash
$ git clone https://github.com/bonzofenix/linkedin-people
$ cd linkedin-people 
$ bundle
```

## running

```ruby
$ ruby linkedin.rb USERNAME PASSWORD > result.csv
```

your result should be something like this:

name, person1-job-description, person1-company, person2-job-description, person2-company, person3-job-description, person3-company


