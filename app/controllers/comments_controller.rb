class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :own_comment, only: %i[edit update destroy] 

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = Comment.new(comment_params)
    @comment.tweet = @tweet
    @comment.user = current_user
    if @comment.save
      redirect_to @tweet, notice: 'Comment was successfully created.'
    else
      redirect_to @tweet, alert: 'Something failed'
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.tweet, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @tweet, notice: 'Comment was successfully destroyed.'
  end

  private
    def set_comment
      @tweet = Tweet.find(params[:tweet_id])
      @comment = Comment.find(params[:id])
    end
    def comment_params
      params.require(:comment).permit(:body)
    end
    def own_comment
      unless current_user == @comment.user
        redirect_to(@comment, notice: "You cannot modify this comment") and return
      end
    end
end
