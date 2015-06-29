class AddMapStuffToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :address, :string
    add_column :blog_posts, :latitude, :float
    add_column :blog_posts, :longitude, :float
  end
end
