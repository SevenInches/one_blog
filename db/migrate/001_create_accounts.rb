class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string  :name
      t.string  :photo
      t.string  :email
      t.string  :crypted_password
      t.string  :role
      t.string  :blog_name
      t.text    :info
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
