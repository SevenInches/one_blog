class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string :title
      t.string :abstract
      t.integer :view
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :blogs
  end
end
