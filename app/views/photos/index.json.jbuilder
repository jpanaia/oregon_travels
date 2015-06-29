json.array!(@photos) do |photo|
  json.extract! photo, :id, :title, :caption, :blog_post_id
  json.url photo_url(photo, format: :json)
end
