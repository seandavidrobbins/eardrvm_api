class SongsController < ApplicationController
  before_action :authenticate, only: [:destroy]
  before_action :set_album, only: [:index]

  def index
    set_album
    render json: {status: 200, songs: @album.get_songs_data}
  end

  def create
    set_album
    song = Song.create(
      title: song_params[:title],
      audio: song_params[:audio],
      album_id: @album.id
    )
    
    if song.save
      render json: { status: 200, message: 'Song successfully uploaded', song: song}
     else
       render json: { status: 422, message: song.errors.full_messages}
    end
  end

  def show
    song = Song.find(params[:id])
    render json: {status: 200, song: song.get_song_data}
  end

  def destroy
    song = Song.destroy(params[:id])

    render json: {status: 204}
  end

  private
    def set_album
      @album = Album.find(params[:album_id])
    end

    def song_params
      # {song: {title: " ", audio: " "} } needs to be like this coming in
      params.required(:song).permit(:title, :audio)
    end
end
