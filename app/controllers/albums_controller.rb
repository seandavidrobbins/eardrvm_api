class AlbumsController < ApplicationController
    before_action :authenticate, only: [:create, :update, :destroy]
    before_action :set_user, only: [:index, :create, :destroy]

    ### To allow create update and delete only by user who is logged in
    ### this condition will be set on the front end UI angular controllers

    def index
        # when the user show route is sent back to the angular router
        # then a http request to this index for albums will be made in
        # a promise or on a button click
        # might or might not need to call set_user
        set_user
        render json: { status: 200, songs: @user.albums }
    end

    def create
        # might or might not need to call set_user
        set_user
        album = Album.create(
            title: album_params[:title],
            description: album_params[:description],
            user_id: @user.id
        )

        if album.save
            render json: { status: 200, album: album }
        else
            render json: { status: 422, album: album, errors: album.errors }
        end
    end

    def show
        # this will show a single album sending that one albums data to
        # the angular front end controller as a response
        # to show all the songs for this album
        # we will either through button click or promise after the response
        # from this route we will do another http request to songs#index
        # which will get the songs all pertaining to this album based on
        # this albums id
        album = Album.find(params[:id])

        if album
            render json: { status: 200, album: album }
        else
            render json: { status: 422, message: 'No content' }
        end
    end

    def update
        album = Album.find(params[:id])

        if album.update(album_params)
            render json: { status: 200, album: album }
        else
            render json: { status: 422, errors: album.errors }
        end
    end

    def destroy
        album = Album.destroy(params[:id])
        render json: { status: 204, error: album.errors }
    end

    private

    def set_user
        @user = User.find(params[:user_id])
    end

    def album_params
        params.required(:album).permit(:title, :description)
    end
end
