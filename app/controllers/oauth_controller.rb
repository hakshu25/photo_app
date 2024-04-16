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
    session[:access_token] = access_token if access_token

    redirect_to root_path
  end

  def tweet
    OauthGatewayService.tweet(session[:access_token], tweet_params)
    redirect_to root_path
  end

  private

  def tweet_params
    params.permit(:title, :url)
  end
end
