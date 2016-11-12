class Song < ApplicationRecord
  belongs_to :album
  has_many :comments, dependent: :destroy

  has_attached_file :audio, {
  # styles: {
    # mp3: {},
    :url => "/assets/get/:id",
    :path => ":Rails_root/assets/:id/:basename.:extension"
  }

    def get_songs_data
  { source: song.audio.url(:mp3) }
end

  validates_attachment :audio,
    :content_type => { :content_type => ["audio/mpeg", "audio/mp3", "audio/mpeg3", "audio/x-mpeg-3"] },
    :file_name => { :matches => [/mp3\Z/] }
end
