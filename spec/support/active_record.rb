require 'active_record'

RSpec.configure do |config|

  config.before do
    ::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
    ::ActiveRecord::Schema.define(:version => 1) do 
    end
  end 

  config.after do
    ::ActiveRecord::Base.connection.tables.each do |table|
      ::ActiveRecord::Base.connection.drop_table(table)
    end
  end 

end
