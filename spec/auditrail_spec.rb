require 'spec_helper'
class TestModel < ActiveRecord::Base
  auditable
end

describe TestModel do
  
  subject { TestModel }

  describe 'a newly created controller' do
    it 'contains a auditable method' do
      subject.should respond_to(:auditable)
    end
  end
end
