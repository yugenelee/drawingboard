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

AccountServices::UserService.register('Admin','admin@drawingboard.com', 'local', 'admin@drawingboard.com', 'pass1234', {first_name: 'DrawingBoard', last_name: 'Admin'})
admin = User.where(email: 'admin@drawingboard.com').first
admin.email_confirmed = true
admin.save!


Priceplan.create! name: 'Basic', description: 'Basic', code: 'basic', price: '0'
Priceplan.create! name: 'Basic Plus', description: 'Basic Plus', code: 'basicplus', price: '59'
Priceplan.create! name: 'Premium', description: 'Premium', code: 'premium', price: '269'