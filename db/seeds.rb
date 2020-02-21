User.destroy_all
Wallet.destroy_all
Location.destroy_all
Trash.destroy_all

user1 = User.create(username: "pabstbottle7", password: "123" )
user2 = User.create(username: "vimarks", password: "123" )
user3 = User.create(username: "boneCruncher", password: "123" )
user4 = User.create(username: "fleshLumpEater", password: "123" )
user5 = User.create(username: "BFG", password: "123" )

rep1 = Reputation.create(user_id: 1, rating: 0.0)
rep2 = Reputation.create(user_id: 2, rating: 0.0)
rep3 = Reputation.create(user_id: 3, rating: 0.0)
rep4 = Reputation.create(user_id: 4, rating: 0.0)
rep5 = Reputation.create(user_id: 5, rating: 0.0)

wallet1 = Wallet.create(balance: 100, user_id: 1)
wallet2 = Wallet.create(balance: 50, user_id: 2)
wallet3 = Wallet.create(balance: 200, user_id: 3)
wallet4 = Wallet.create(balance: 75, user_id: 4)
wallet5 = Wallet.create(balance: 50, user_id: 5)

location1 = Location.create(latitude: 30.254652, longitude: -97.749227)
location2 = Location.create(latitude: 30.253318, longitude: -97.716283)
location3 = Location.create(latitude: 30.254116, longitude: -97.747039)
location4 = Location.create(latitude: 30.255116, longitude: -97.740639)
location5 = Location.create(latitude: 30.256116, longitude: -97.740839)

trash1 = Trash.create(bounty: 15, location_id: 4, cleaner_id: nil , reporter_id: 5, cleaned: "dirty", description: "Bottles in river")
trash2 = Trash.create(bounty: 85, location_id: 3, cleaner_id: nil, reporter_id: 5, cleaned: "dirty", description: "On the south shore of LadyBird lake, right by Joe's Crab Shack")
trash3 = Trash.create(bounty: 5, location_id: 2, cleaner_id: nil, reporter_id: 5, cleaned: "dirty", description: "Edge of the woods across from the Burger King")
trash4 = Trash.create(bounty: 35, location_id: 1, cleaner_id: nil, reporter_id: 5, cleaned: "dirty", description: "Big pile of bottles near the cemetary")
trash5 = Trash.create(bounty: 35, location_id: 5, cleaner_id: nil, reporter_id: 2, cleaned: "dirty", description: "Bags of trash CLOSE to the dumpster")
