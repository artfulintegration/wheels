class CreateAccessControlEntries < ActiveRecord::Migration
  def self.up
    create_table :access_control_entries do |t|
      t.string :resource_type
      t.integer :resource_id
      t.integer :user_id
      t.integer :role_id
      t.boolean :can
      t.string :verb
      t.string :serialized_options
      t.timestamps
    end
    add_index :access_control_entries, :resource_type
    add_index :access_control_entries, [:resource_type, :resource_id]
    add_index :access_control_entries, :user_id
    add_index :access_control_entries, :role_id
  end

  def self.down
    drop_table :access_control_entries
  end
end

