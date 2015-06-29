class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index, :show, :map]

  # GET /blog_posts
  # GET /blog_posts.json
  def index
    @blog_posts = BlogPost.order(posted_at: :desc)
    @latlongarray = BlogPost.order(posted_at: :desc).all.collect {|blog_post| [blog_post.address, blog_post.latitude, blog_post.longitude, blog_post.blog_entry[0..50], blog_post.photo.url(:small), blog_post.friendly_id, blog_post.title]}
    response = HTTParty.get("https://api.instagram.com/v1/tags/oregontrailgirls/media/recent?access_token=2682.bb484d1.e90b2e38118a40fcaa13186b24649df2")
    response2 = HTTParty.get("https://api.instagram.com/v1/tags/oregontrailgirls?access_token=2682.bb484d1.e90b2e38118a40fcaa13186b24649df2")
    @count = response2["data"]["media_count"]
    # @link = response["data"][i]["link"]

    # @photos = []
    @links = []

    @photo_hash = {}

    i = 0
    if @count < 18
      @count.times do
        @photo_hash[response["data"][i]["images"]["standard_resolution"]["url"]] = response["data"][i]["caption"]["text"]
        i+=1
      end
    else
      18.times do
     # @photos = @photos.push(response["data"][i]["images"]["thumbnail"]["url"])
      @links = @links.push(response["data"][i]["link"])
      @photo_hash[response["data"][i]["images"]["standard_resolution"]["url"]] = response["data"][i]["caption"]["text"]
      i+=1
    end
  end
  end

  def showusers
    @users = User.all.order(created_at: :desc)
  end

  # GET /blog_posts/1
  # GET /blog_posts/1.json
  def show
    @blog_posts = BlogPost.all
    @photo = Photo.new
    @comment = Comment.new
    @post_date = @blog_post.posted_at.strftime('%B %e, %Y')
    @post_time = @blog_post.posted_at.strftime('%-I:%M%P %Z')
    @first_photo = @blog_post.photos.first
  end

  # GET /blog_posts/new
  def new
    @blog_post = BlogPost.new
  end

  # GET /blog_posts/1/edit
  def edit
  end

  # POST /blog_posts
  # POST /blog_posts.json
  def create
    @blog_post = BlogPost.new(blog_post_params)

    respond_to do |format|
      if @blog_post.save
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully created.' }
        format.json { render :show, status: :created, location: @blog_post }
      else
        format.html { render :new }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog_posts/1
  # PATCH/PUT /blog_posts/1.json
  def update
    respond_to do |format|
      if @blog_post.update(blog_post_params)
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog_post }
      else
        format.html { render :edit }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_posts/1
  # DELETE /blog_posts/1.json
  def destroy
    @blog_post.destroy
    respond_to do |format|
      format.html { redirect_to blog_posts_url, notice: 'Blog post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog_post
      @blog_post = BlogPost.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_post_params
      params.require(:blog_post).permit(:title, :author, :blog_entry, :user_id, :photo, :address, :latitude, :longitude, :friendly_id, :posted_at)
    end
end
