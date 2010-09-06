class CreateCredentials < ActiveRecord::Migration
  def self.up
    create_table :credentials do |t|
      t.string :service
      t.string :username
      t.string :crypted_password

      t.timestamps
    end
  end

  def self.down
    drop_table :credentials
  end
end
