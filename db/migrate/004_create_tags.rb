class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :tag_name
      t.timestamps
    end
  end

  execute "alter table blogs add constraint fk_blog_tag foreign key(tag) references tags(id)"

  def self.down
    drop_table :tags
  end
end
