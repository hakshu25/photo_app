require 'net/http'

class OauthGatewayService
  HOST = ENV.fetch("OAUTH_HOST")
  CLIENT_ID = ENV.fetch('OAUTH_CLIENT_ID')
  CLIENT_SECRET = ENV.fetch("OAUTH_CLIENT_SECRET")
  REDIRECT_URI = ENV.fetch('REDIRECT_URI')

  class << self
    def authorize_url
      "#{HOST}/oauth/authorize?client_id=#{CLIENT_ID}&redirect_uri=#{REDIRECT_URI}&response_type=code&scope=write_tweet"
    end

    def create_access_token(auth_code)
      uri = URI("#{HOST}/oauth/token")
      request = Net::HTTP::Post.new(uri)
      request.set_form_data(
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        code: auth_code,
        redirect_uri: REDIRECT_URI,
        grant_type: "authorization_code"
      )

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(request)
      end
      Rails.logger.debug(response)

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)['access_token']
      else
        nil
      end
    end

    def tweet(access_token, tweet_params)
      uri = URI("#{HOST}/api/tweets")
      request = Net::HTTP::Post.new(uri, 'Authorization' => "Bearer #{access_token}", 'Content-Type' => 'application/json')
      request.body = { text: tweet_params[:title], url: tweet_params[:url] }.to_json

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(request)
      end
      Rails.logger.debug(response)

      case response
      when Net::HTTPSuccess
        true
      else
        false
      end
    end
  end
end
