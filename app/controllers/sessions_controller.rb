class SessionsController < ApplicationController
  def new
  end

  def create
    if session_params[:user_id].blank? || session_params[:password].blank?
      error_messages = []
      error_messages << "ユーザーIDを入力してください" if session_params[:user_id].blank?
      error_messages << "パスワードを入力してください" if session_params[:password].blank?
      flash.now[:alert] = error_messages.join("\n")
      render 'new'
      return
    end

    user = User.find_by(account_id: session_params[:user_id])
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:alert] = "ユーザーIDが登録されていないか、パスワードが違います"
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    reset_current_user
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session).permit(:user_id, :password)
  end
end
