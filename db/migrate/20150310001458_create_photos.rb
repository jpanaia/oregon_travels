class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.string :caption
      t.integer :blog_post_id

      t.timestamps null: false
    end
  end
end
