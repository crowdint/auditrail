# auditrail

An easy and unobtrusive way to track changes on Active Record models.

## Installing

Currently this gem is under development.

## Usage

First run the generator to create the *audits* table:
  
    rails g auditrail:create

This will create a migration. Now Simply add *auditable* to your models 
like this:

    class User < ActiveRecord::Base
      auditable
    end

### Options

None yet, but we want to let the implementor configure where to store the audits, 
what the audit table name will be and filter what data you want to audit.


# Development

If you want to make changes to the gem then fork it and first install bundler:

    gem install bundler

And then, install all your dependencies:

    bundle install

## Running the test suite

Simply run:

    rake

# Changelog

Nothing yet.

# About the Author

[Crowd Interactive](http://www.crowdint.com) is an American web design and development 
company that happens to work in Colima, Mexico. We specialize in building and growing 
online retail stores. We don’t work with everyone – just companies we believe in. Call 
us today to see if there’s a fit.

Find more info [here](http://www.crowdint.com)!
