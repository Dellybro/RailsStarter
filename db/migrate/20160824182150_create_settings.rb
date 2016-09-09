class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|

    	t.string :objectId
    	t.boolean :send_emails
    	t.integer :user_id

      t.timestamps null: false
    end
  end
end
