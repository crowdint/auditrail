class CreateAuditrails < ActiveRecord::Migration
  def self.up
    create_table :auditrails do |t|
      t.string :after
      t.string :before

      t.timestamps
    end
  end

  def self.down
    drop_table :auditrails
  end
end
