require 'active_record'
require 'active_support/concern'
require 'yaml'

module Auditrail
  extend ActiveSupport::Concern

  module ClassMethods
    def auditable(*options, &block)
      
      class_eval do
        before_create :if => "changed?" do
          track_changes(:creating, options, &block)
        end
        before_update :if => "changed?" do
          track_changes(:updating, options, &block)
        end
        after_save do
          save_tracked_changes
        end
      end
    end
  end

  module InstanceMethods
    private
    def track_changes(*options, &block)
      action = options[0]
      @audit = Audit.new
      @audit.dumped_changes = YAML.dump(changes)
      @audit.model_changed = self.class
      @audit.action = action
      @audit.invoker = YAML.dump(block.call) if block
    end

    def save_tracked_changes
      @audit.element_id = id
      @audit.save
    end
  end
end

ActiveRecord::Base.send(:include, Auditrail)
