class AddLargeCoverAndSmallCoverToVideos < ActiveRecord::Migration[6.1]
  def change
  	add_column :videos, :large_cover, :string
    add_column :videos, :small_cover, :string

    remove_column :videos, :small_cover_url
    remove_column :videos, :large_cover_url
  end
end
