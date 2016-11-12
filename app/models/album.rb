class Album < ApplicationRecord
  belongs_to :user
  has_many :songs, dependent: :destroy

  def get_songs_data
    # needs songs id and url thumb
    songs.map { |song|
      song = {
        id: song.id,
        title: song.title,
        audio_file_name: song.audio_file_name,
        audio_thumb_url: song.audio.url,
        audio_large_url: song.audio.url
      }
    }
  end
end
