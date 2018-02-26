# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
user = CreateSellerService.new.call
puts 'CREATED SELLER USER: ' << user.email
customer = CreateCustomerService.new.call
puts 'CREATED CUSTOMER USER: ' << customer.email

# products
laptop = Product.create(name: 'Laptop',
                        stock_level: 48,
                        price: 999.99,
                        brand: 'Dell',
                        material: 'Metal',
                        weight: 1.5,
                        description: 'This is a laptop computer.'
)
headphones = Product.create(name: 'Headphones',
                            stock_level: 209,
                            price: 149.90,
                            brand: 'Sennheiser',
                            material: 'Black Plastic',
                            weight: 0.28,
                            description: 'Wireless headphones that connect via Bluetooth. 30 hours battery time.'
)
keyboard = Product.create(name: 'Wireless Keyboard',
                          stock_level: 82,
                          price: 39.00,
                          brand: 'Logitech',
                          material: 'Plastic',
                          weight: 0.45,
                          description: 'This wireless keyboard connects via Logitech\' Unifying Adapter.'
)
mouse = Product.create(name: 'Wireless Mouse',
                       stock_level: 504,
                       price: 29.00,
                       brand: 'Dell',
                       material: 'Plastic',
                       weight: 0.21,
                       description: 'This wireless mouse connects via Logitech\' Unifying Adapter.'
)
speakers = Product.create(name: 'Speaker',
                          stock_level: 87,
                          price: 79.49,
                          brand: 'Sennheiser',
                          material: 'Aluminium',
                          weight: 3.5,
                          description: 'Large speakers for great sound.'
)
card_reader = Product.create(name: 'Card Reader',
                             stock_level: 255,
                             price: 9.99,
                             brand: 'SanDisk',
                             material: 'Black Plastic',
                             weight: 0.89,
                             description: 'Reads SD cards and Memory Sticks.'
)
charger = Product.create(name: 'Laptop Charger',
                         stock_level: 19,
                         price: 25.00,
                         brand: 'Dell',
                         material: 'Plastic',
                         weight: 0.56,
                         description: 'Charges your laptop.'
)
screen = Product.create(name: 'Computer Screen',
                        stock_level: 72,
                        price: 349.99,
                        brand: 'Samsung',
                        material: 'Metal',
                        weight: 1.9,
                        description: '27" computer screen that connects via HDMI".'
)