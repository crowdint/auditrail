class CreateAudits < ActiveRecord::Migration
  def self.up
    create_table :audits do |t|
      t.string :after
      t.string :before

      t.timestamps
    end
  end

  def self.down
    drop_table :audits
  end
end
