class AddPostedatToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :posted_at, :datetime
  end
end
