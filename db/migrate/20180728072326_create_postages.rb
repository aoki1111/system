class CreatePostages < ActiveRecord::Migration[5.2]
  def change
    create_table :postages do |t|
        t.string :type
        t.integer :hokkaido
        t.integer :kitatouhoku
        t.integer :minamitouhoku
        t.integer :kantou
        t.integer :tokyo
        t.integer :shinetsu
        t.integer :chubu
        t.integer :kansai
        t.integer :chugoku
        t.integer :shikoku
        t.integer :kitakyushu
        t.integer :minamikyushu
        t.integer :okinawa
        t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
