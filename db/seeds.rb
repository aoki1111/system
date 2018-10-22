# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(corporate_name:"AFTECH株式会社",lastname:"鈴木",firstname:"康修",lastname_phonetic:"スズキ", firstname_phonetic:"ヤスノブ",email:"ys3128@gmail.com", phone:"09041504375",zipcode:"1050022",pref:"東京都",area:"Kantou",city:"港区", street:"海岸2-6-31", activated:true, activated_at:Time.now,admin:true, password:"yasu3128")
user.product_items.create(product_id:1)
user.stocks.create(shipment_week:Date.today.beginning_of_week.cweek,quantity:30,salable:Time.now.beginning_of_week,pref:"東京都",area:"Kantou")
