require 'active_record'
require 'active_support/concern'
require 'yaml'
require 'generators/migrations'
require 'generators/model'
require 'audit_options'

module Auditrail

  extend ActiveSupport::Concern

  module ClassMethods

    def auditable(&block)
      audit_options = block ? AuditOptions.new(&block) : AuditOptions.new

      class_eval do
        before_create do
          track_changes(:creating, audit_options.user) if attributes_changed?(*audit_options.attributes)
        end

        before_update do
          track_changes(:updating, audit_options.user) if attributes_changed?(*audit_options.attributes)
        end

        after_save do
          save_tracked_changes if attributes_changed?(*audit_options.attributes)
        end
      end

    end

  end

  module InstanceMethods

    private
    def attributes_changed?(*options)
      ((options - changes.keys) != options || options.empty?) & changed?
    end
    
    
    def track_changes(*options)
      action = options[0]
      @audit = Audit.new
      @audit.dumped_changes = YAML.dump(changes)
      @audit.model_changed = self.class
      @audit.action = action
      @audit.invoker = YAML.dump(options[1])
    end

    def save_tracked_changes
      @audit.element_id = id
      @audit.save
    end
    
  end

end

ActiveRecord::Base.send(:include, Auditrail)
