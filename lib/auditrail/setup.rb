require 'active_record'
require 'active_support/concern'

module Auditrail
  extend ActiveSupport::Concern

  module ClassMethods
    def auditable(*options)

    end
  end

  module InstanceMethods
    include ActiveSupport::Callbacks

  end
end


ActiveRecord::Base.send(:include, Auditrail)
