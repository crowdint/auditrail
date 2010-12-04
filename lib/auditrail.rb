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

    #define_callbacks :save, :create, :update

  end
end


ActiveRecord::Base.send(:include, Auditrail)
