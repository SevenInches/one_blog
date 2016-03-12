class AddTagAndStateToBlog < ActiveRecord::Migration
  def self.up
    change_table :blogs do |t|
      t.integer :tag_id
    t.integer :state
    end
  end

  def self.down
    change_table :blogs do |t|
      t.remove :tag_id
    t.remove :state
    end
  end
end
