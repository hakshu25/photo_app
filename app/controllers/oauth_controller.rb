class OauthController < ApplicationController
  def authorize
    redirect_to OauthGatewayService.authorize_url, allow_other_host: true
  end

  def callback
    auth_code = params.permit(:code)[:code]
    if auth_code.blank?
      Rails.logger.error("auth_code is blank")
      redirect_to root_path
      return
    end

    access_token = OauthGatewayService.create_access_token(auth_code)
    if access_token
      session[:access_token] = access_token
      flash[:success] = '連携に成功しました。'
    else
      flash[:alert] = '連携に失敗しました。時間をおいて再度お試しください。'
    end

    redirect_to root_path
  end

  def tweet
    result = OauthGatewayService.tweet(session[:access_token], tweet_params)
    if result
      flash[:success] = 'ツイート成功しました。'
    else
      flash[:alert] = 'ツイートに失敗しました。時間をおいて再度お試しください。'
    end

    redirect_to root_path
  end

  private

  def tweet_params
    params.permit(:title, :url)
  end
end
