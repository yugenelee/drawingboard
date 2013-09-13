categories = {
  venues: 'Venues',
  catering: 'Catering',
  photography: 'Photography',
  videography: 'Videography',
  entertainment: 'Entertainment',
  cakes: 'Cakes',
  transport: 'Transport',
  decor: 'Decor',
  flowers: 'Flowers',
  invitations_and_stationery: 'Invitations & Stationery',
  fashion_and_accessories: 'Fashion & Accessories',
  hair_and_beauty: 'Hair & Beauty',
  novelty_services: 'Novelty services',
  supplies_and_party_favours: 'Supplies & Party Favours'
}

categories.each do |name, display_name|
  Service.create!(name: name.to_s, display_name: display_name)
end