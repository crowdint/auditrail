$:.unshift File.join(File.dirname(__FILE__))
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'auditrail'
require 'active_record'

=begin
::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
  ::ActiveRecord::Schema.define(:version => 1) do
    create_table :products do |t|
      t.column :name, :string
  end
end
=end

