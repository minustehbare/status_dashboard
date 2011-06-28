class AddTitleAndBodyToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :title, :string
    add_column :posts, :body, :text
  end

  def self.down
    remove_column :posts, :title
    remove_column :posts, :body
  end
end
