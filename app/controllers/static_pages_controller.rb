class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
    require 'twitter'
    
    # client = Twitter::Streaming::Client.new do |config|
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.credentials.user_consumer_key
      config.consumer_secret = Rails.application.credentials.user_consumer_secret
      config.access_token = Rails.application.credentials.user_access_token
      config.access_token_secret = Rails.application.credentials.user_access_token_secret
    end

    id = '1528199450866626560?s=21&t=RhIzzIBwyqC8ZRvCNKhUfg'
    puts client.methods
    @tweet = client.status(id)
    puts @tweet.methods
  end
  
  def about
  end
  
  def contact
  end
end
