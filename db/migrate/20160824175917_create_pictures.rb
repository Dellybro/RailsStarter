class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|

      t.string :objectId

  	  t.string :uploader
      t.string :name
      # If this is blank
      # No image is uploaded
      t.string :filename

      # Kinda like putting the pictures in buckets. They can be associated by picture index
      t.integer :picture_index
      t.references :imageable, polymorphic: true, index: true


      t.timestamps null: false
    end
  end
end
