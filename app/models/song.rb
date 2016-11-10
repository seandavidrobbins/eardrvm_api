class Song < ApplicationRecord
  belongs_to :album
  has_many :comments, dependent: :destroy
  # has_attached_file :audio, styles: {
  #   large: '600x600>',
  #   medium: '300x300>',
  #   thumb: '200x200>',
  #   square: '200x200#'
  # }

  # def get_song_data
  #   { source: song.audio.url(:large) }
  # end
  #
  # # Validate the attached image is image/jpg, image/png, etc
  # validates_attachment_content_type :image, :content_type => /^image\/(png|gif|jpeg)/
end
