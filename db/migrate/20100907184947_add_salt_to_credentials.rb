class AddSaltToCredentials < ActiveRecord::Migration
  def self.up
    add_column :credentials, :salt, :string
  end

  def self.down
    remove_column :credentials, :salt
  end
end
