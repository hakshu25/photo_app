class PhotosController < ApplicationController
  def new
    # TODO: ログイン機能を作成したら、ログインしているユーザーに紐づけて写真を投稿できるようにする
    @user = User.find(params[:user_id])
    @photo = @user.photographs.build
  end

  def create
    @user = User.find(params[:user_id])
    @photo = @user.photographs.build(photo_params)

    if @photo.save
      redirect_to new_photo_path(user_id: params[:user_id])
    else
      render :new
    end
  end

  private

  def photo_params
    params.require(:photograph).permit(:title, :image)
  end
end
