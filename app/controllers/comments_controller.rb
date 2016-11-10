class CommentsController < ApplicationController
  before_action :authenticate, only: [:create, :destroy]
  before_action :set_user, only: [:create]
  before_action :set_song, only: [:index, :create, :destroy]

  def index
    set_song
    render json: {status: 200, comments: @song.comments}
  end

  def create
    comment = Comment.create(
      body: comment_params[:body],
      song_id: @song.id,
      username: @user.username,
      user_id: @user.id
    )

    if comment.save
      render json: {status: 200, comments: @song.comments}
    else
      render json: {status: 422, message: "No content"}
    end
  end

  def destroy
    set_song
    comment = Comment.destroy(params[:id])
    render json: {status: 200, comments: @song.comments}
  end

  private
    def set_song
      @song = Song.find(params[:song_id])
    end

    def set_user
      puts "Current_USER::::::"
      user = current_user
      user = user[0]
      @user = User.find(user["user"]["id"])
    end

    def comment_params
      params.required(:comment).permit(:body)
    end
end
