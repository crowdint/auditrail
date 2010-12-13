require 'yaml'

class Audit < ActiveRecord::Base
  def action_invoker
    YAML.load(invoker)
  end
  
  def self.model_filter(model_changed)
    where("model_changed = ?", model_changed.to_s.camelize)
  end

  def self.action_filter(action)
    where("action = ?", action.to_s)
  end
end
