class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :own_tweet, only: %i[edit update destroy] 

  def index
    @tweets = Tweet.all
  end

  def show; end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      redirect_to @tweet, notice: 'Tweet was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @tweet.update(tweet_params)
      redirect_to @tweet, notice: 'Tweet was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to categories_url, notice: 'Tweet was successfully destroyed.'
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end
    def tweet_params
      params.require(:tweet).permit(:body)
    end
    def own_tweet
      unless current_user == @tweet.user
        redirect_to(@tweet, notice: "You cannot modify this tweet") and return
      end
    end
end
