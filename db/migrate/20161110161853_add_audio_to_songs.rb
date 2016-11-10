class AddAudioToSongs < ActiveRecord::Migration[5.0]
    def self.up
    add_attachment :songs, :audio
  end

  def self.down
    remove_attachment :songs, :audio
  end
end
