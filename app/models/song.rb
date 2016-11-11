class Song < ApplicationRecord
  belongs_to :album
  has_many :comments, dependent: :destroy

    has_attached_file :audio

    # validates_attachment_presence :mp3
    validates_attachment_size :mp3, :less_than => 10.megabytes,
    :message => 'filesize must be less than 10 MegaBytes'
    validates_attachment_content_type :mp3, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ],
                  :message => 'file must be of filetype .mp3'

end
