class PhotosController < ApplicationController
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
    @photos = current_user.photographs
  end

  private

  def photo_params
    params.require(:photograph).permit(:title, :image)
  end
end
