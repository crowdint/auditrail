# auditrail

An easy and unobtrusive way to track changes on Active Record models.


## How it works

This will generate a table named *audits* where we will save an audit entry each time an audited model change.

You can find an example application you can use for testing [here](https://github.com/MGalv/auditrails_test_app).

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

You can define your options using a block.

With the option *for_attributes* you can select the fields that you want to audit. For example:

auditable do
  for_attributes "name", "email"
end

This will save an audit each time the fields "name" or "email" change.

With the option *by_name* you can save the action invoker.

auditable do
  by_user "user"
end

Also, you can call the method *by_user* as a block. For example:

auditable do
  by_user do
    "user"
  end
end

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

# To Do

* Let the implementor configure where to store the audits.
* What the audit table name will be.

# About the Author

[Crowd Interactive](http://www.crowdint.com) is an American web design and development 
company that happens to work in Colima, Mexico. We specialize in building and growing 
online retail stores. We don’t work with everyone – just companies we believe in. Call 
us today to see if there’s a fit.

Find more info [here](http://www.crowdint.com)!
