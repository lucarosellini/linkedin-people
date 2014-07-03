Linkedin people search
======================

This automated script searches possible matches people in likedin searching them by name.
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

with a file with names:
```csv
Mark Anthony, other information
Chris Cornell, other information
```
you can run:
```ruby
  $ ruby linkedin.rb USERNAME PASSWORD FILEPATH > result.csv
```

your result should be something like this:

```csv
name_person_1, result1-job-description, result1-company, result2-job-description, result2-company, result3-job-description, result3-company
```


