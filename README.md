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
# ruby code
class Country < ActiveRecord::Base
  include Mastar
  mastar.key :code
end
```
### Countries table data

|id|name |code|
|--|-----|----|
| 1|USA  |us  |
| 2|Japan|jp  |

1. Can direct access by key method. (ex. `Country.jp` returns `#<Country id: 2, name: "Japan", code: "jp", ...>`)
2. Can use `.get` method like as `.find`, `.get` preferentially returns cached object.
3. Can use `.pairs` method.
```ruby 
# Normal
f.select :country_id, Country.all.map { |c| [c.name, c.id] }
f.collection_select :country_id, Country.all, :id, :name
# In using Mastar
f.select :country_id, Country.pairs
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
