require 'active_record'

RSpec.configure do |config|

  config.before do
    ::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
    ::ActiveRecord::Schema.define(:version => 1) do 
    end
    @auditrail_class = Object.const_set(:Auditrail, Class.new(::ActiveRecord::Base))
  end 

  config.after do
    Object.send(:remove_const, :Auditrail)
    ::ActiveRecord::Base.connection.tables.each do |table|
      ::ActiveRecord::Base.connection.drop_table(table)
    end
  end 

end
