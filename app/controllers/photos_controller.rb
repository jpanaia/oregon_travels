class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
    redirect_to blog_posts_path
  end

  # # GET /photos/1
  # # GET /photos/1.json
  def show
    redirect_to blog_posts_path
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
     redirect_to blog_posts_path
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to blog_post_path(id: @photo.blog_post_id), notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: blog_post_path(id: @photo.blog_post_id) }
      else
        format.html { render :new }
        format.json { render json: blog_post_path(id: @photo.blog_post_id).errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to blog_post_path(id: @photo.blog_post_id), notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:title, :caption, :blog_post_id, :photo)
    end
end