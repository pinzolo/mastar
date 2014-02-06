# Mastar

[![Build Status](https://secure.travis-ci.org/pinzolo/mastar.png)](http://travis-ci.org/pinzolo/mastar)
[![Coverage Status](https://coveralls.io/repos/pinzolo/mastar/badge.png)](https://coveralls.io/r/pinzolo/mastar)

Add some features to master table class on ActiveRecord.

## Installation

Add this line to your application's Gemfile:

    gem 'mastar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mastar

## Usage

1. Call `include Mastar` in your ActiveRecord classes.
2. Set key column name by way of `mastar.key` method.

## Feature

### Ruby code

```ruby
class Country < ActiveRecord::Base
  include Mastar
  mastar.key :code
end

class City < ActiveRecord::Base
  belongs_to :country
end
```
### Countries table data

| id | name | code |
|---:|:-----|:-----|
|1   |USA   |us    |
|2   |Japan |jp    |

1. Direct access by key method.  
    * `Country.jp` returns `#<Country id: 2, name: "Japan", code: "jp", ...>`
    * `Country.jp(:name)` returns `"Japan"`
    * `Country.jp(:code, :name, :id)` returns `["jp", "Japan", 2]`
2. Judge method by key. (ex. `City.first.country.jp?`)
3. `.get` method like as `.find`, `.get` preferentially returns cached object.
    * `Country.find` returns from DB.
    * `Country.get` returns from inner cache when already cached.
    * When not cached, `Country.get` returns from DB, and cache it.
4. `.pairs` method for writing select element shortly in Rails.
```ruby 
# Normal
f.select :country_id, Country.all.map { |c| [c.name, c.id] }
f.collection_select :country_id, Country.all, :id, :name
# In using Mastar
f.select :country_id, Country.pairs
```
## Supported versions

- Ruby: 1.9.3, 2.0.0, 2.1.0
- ActiveRecord: 3.2.x, 4.0.x

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
