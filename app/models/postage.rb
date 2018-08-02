class Postage < ApplicationRecord
    belongs_to :user,  optional: true

    validates :item_type, presence: true
    validates :company, presence: true
    validates :hokkaido, presence:true
    validates :kitatouhoku, presence: true, allow_blank:true
    validates :minamitouhoku, presence: true, allow_blank:true
    validates :touhoku, presence: true, allow_blank:true
    validates :kantou, presence: true
    validates :tokyo, presence: true , allow_blank:true
    validates :shinetsu, presence: true
    validates :hokuriku, presence: true
    validates :chubu, presence: true
    validates :kansai, presence: true
    validates :chugoku, presence: true
    validates :shikoku, presence: true
    validates :kyushu, presence: true , allow_blank:true
    validates :kitakyushu, presence: true , allow_blank:true
    validates :minamikyushu, presence: true , allow_blank:true
    validates :okinawa, presence: true , allow_blank:true

end
