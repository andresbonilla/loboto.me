class CreateCredentials < ActiveRecord::Migration
  def self.up
    create_table :credentials do |t|
      t.string :service
      t.string :username
      t.string :crypted_password
      t.integer :user_id
      t.timestamps
    end
    add_index :credentials, :user_id
  end

  def self.down
    drop_table :credentials
  end
end
