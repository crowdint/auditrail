require 'active_record'
require 'active_support/concern'
require 'yaml'

module Auditrail
  extend ActiveSupport::Concern

  module ClassMethods
    def auditable(*options)
      
      class_eval do
        before_create :if => "changed?" do
          track_changes(:creating)
        end
        before_update :if => "changed?" do
          track_changes(:updating)
        end
      end
    end
  end

  module InstanceMethods
    def track_changes(*options)
      action = options.first
      audit = Audit.new
      audit.dumped_changes = YAML.dump(changes)
      audit.action = action
      audit.save
    end
  end
end

ActiveRecord::Base.send(:include, Auditrail)
