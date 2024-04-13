class PhotosController < ApplicationController
  def new
    # TODO: ログイン機能を作成したら、ログインしているユーザーに紐づけて写真を投稿できるようにする
    @user = User.find(params[:user_id])
    @photo = @user.photographs.build
  end
end
