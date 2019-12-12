User.destroy_all
Wallet.destroy_all
Location.destroy_all
Trash.destroy_all

user1 = User.create(username: "pabstbottle7", password: "123" )
user2 = User.create(username: "vimarks", password: "123" )
user3 = User.create(username: "boneCruncher", password: "123" )
user4 = User.create(username: "fleshLumpEater", password: "123" )
user5 = User.create(username: "BFG", password: "123" )

wallet1 = Wallet.create(balance: 100, user_id: 1)
wallet1 = Wallet.create(balance: 50, user_id: 2)
wallet1 = Wallet.create(balance: 0, user_id: 3)

location1 = Location.create(latitude: 30.254652, longitude: -97.749227)
location2 = Location.create(latitude: 30.253318, longitude: -97.716283)
location3 = Location.create(latitude: 30.252116, longitude: -97.740039)

trash1 = Trash.create(bounty: 15, location_id: 1, cleaner_id: nil , reporter_id: 4, cleaned: false, description: "In the alley way between the dinner and the hotel")
trash2 = Trash.create(bounty: 85, location_id: 3, cleaner_id: nil, reporter_id: 5, cleaned: false, description: "On the south shore of LadyBird lake, right by Joe's Crab Shack")
trash3 = Trash.create(bounty: 5, location_id: 2, cleaner_id: nil, reporter_id: 5, cleaned: false, description: "Edge of the woods across from the Burger King")
