class PhotosController < ApplicationController
  before_action :require_login
  helper_method :image_url

  def new
    @photo = current_user.photographs.build
  end

  def create
    @photo = current_user.photographs.build(photo_params)

    if @photo.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @photos = current_user.photographs.with_attached_image.sort_latest_order
  end

  def image_url(image)
    url_for(image)
  end

  private

  def photo_params
    params.require(:photograph).permit(:title, :image)
  end
end
