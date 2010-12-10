class CreateAudits < ActiveRecord::Migration
  def self.up
    create_table :audits do |t|
      t.string :dumped_changes
      t.string :action
      t.string :model_changed
      t.integer :element_id
      t.string :invoker
      
      t.timestamps
    end
  end

  def self.down
    drop_table :audits
  end
end
