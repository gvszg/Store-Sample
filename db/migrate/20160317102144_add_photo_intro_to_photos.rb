class AddPhotoIntroToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :photo_intro, :string
  end
end