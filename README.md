# auditrail
An easy and unobtrusive way to track changes on Active Record models (only tested with Ruby 1.9.2).


## How it works
This will generate a table named **audits**. **auditrail** will save an *audit entry* each time 
an *audited model* changes.

You can find an example application that shows how to use **auditrail** 
[here](https://github.com/MGalv/auditrails_test_app).


## Installing
It has only been tested on rails3, in order to install it do:

    gem install auditrail


## Usage
First run the generator to create the *audits* table:
  
    rails g auditrail:create

That will create a migration. Now Simply add *auditable* to your models like this:

    class User < ActiveRecord::Base
      auditable
    end


### Options
You can define parameter options with a block.

#### for_attributes
Using *for_attributes* you select the fields that you want to be audited. For example:

    auditable do
      for_attributes "name", "email"
    end

This will create an *audit entry* by each time that the fields *name* or *email* change.

#### by_user
Using *by_user* you control who was the *action invoker* or *fields modifier*:

    auditable do
      by_user "user"
    end

Also, you can call the method *by_user* with a block as parameter. For example:

    auditable do
      by_user do
        "user"
      end
    end

This way you may dynamically control what will be saved as the *action invoker* or 
*fields modifier*.


# Development
If you want to make changes to the gem, then fork it, and first install bundler:

    gem install bundler

Afterwards, install the bundle:

    bundle install


## Running the test suite
Simply run:

    rake


# Changelog
Nothing yet.


# To Do
* Improve the way the changes are stored when the table field length is exceeded.
* Refactor auditrail.rb and its tests.
* Let the implementor configure where to store the audits.
* What the audit table name will be.

# Changelog

* 0.0.4 Fixed validation to check unchanged attributes when updating.

# About the Author
[Crowd Interactive](http://www.crowdint.com) is an American web design and development 
company that happens to work in Colima, Mexico. We specialize in building and growing 
online retail stores. We don’t work with everyone – just companies we believe in. Call 
us today to see if there’s a fit.

Find more info [here](http://www.crowdint.com)!
