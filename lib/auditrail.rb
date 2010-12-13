require 'active_record'
require 'active_support/concern'
require 'yaml'

module Auditrail
  extend ActiveSupport::Concern

  module ClassMethods
    def auditable(*options, &block)
      
      class_eval do
        options = options.extract_options!
        attributes = options[:for_attributes]
        before_create do
          track_changes(:creating, &block) if attributes_changed?(*attributes)
        end
        before_update do
          track_changes(:updating, &block) if attributes_changed?(*attributes)
        end
        after_save do
          save_tracked_changes if attributes_changed?(*attributes)
        end
      end
    end
  end

  module InstanceMethods
    
    private
    def attributes_changed?(*options)
      (options - changes.keys) != options || options.empty?
    end
    
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
    
    def class_elements
      
    end
  end
end

ActiveRecord::Base.send(:include, Auditrail)
