require 'yaml'

class Audit < ActiveRecord::Base
  def action_invoker
    YAML.load(invoker)
  end
end
