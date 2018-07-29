class CreateUsers < ActiveRecord::Migration[5.2]
  def change
      create_table :users do |t|
        t.string :corporate_name
        t.string :lastname
        t.string :firstname
        t.string :lastname_phonetic
        t.string :firstname_phonetic
        t.string :email
        t.string :phone
        t.string :zipcode
        t.string :pref
        t.string :area
        t.string :city
        t.string :street
        t.string :building
        t.string :password_digest
        t.string :remember_digest
        t.string :activation_digest
        t.datetime :activated_at
        t.boolean :activated, default: false
        t.string :reset_digest
        t.datetime :reset_sent_at
        t.boolean :admin, default: false
        t.timestamps
      end
      add_index :users, :email, unique: true
      add_index :users, :pref
      add_index :users, :area
  end
end
