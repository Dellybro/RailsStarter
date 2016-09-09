class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|


      t.string :first_name
      t.string :last_name
      t.string :full_name
    	t.string :email
    	t.string :password
      t.string :password_digest
    	t.string :objectId
    	t.string :username

      t.boolean :activated
      t.datetime :activated_at
      t.datetime :last_login
      t.datetime :reset_sent_at
    	# Correlate with attr_accessors (var-name)_token
    	t.string :reset_digest
    	t.string :activation_digest
    	t.string :remember_digest

      t.string :auth_token
      
      t.timestamps null: false
    end
  end
end
