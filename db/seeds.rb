
puts "Create Admin"

admin = Admin.create(email: "rodolphosnow@gmail.com", password: "fuvest01")
admin = Admin.create(email: "admin@essenciasfluir.com.br", password: "essencias@2017")


image = File.open("#{Rails.root}/app/assets/images/default.jpg")

puts "Categories"

puts "Bicicletas"
category = Category.create(name: "Bicicletas", active: true)
puts "Subcategories Bicicletas"
subcategories = ["Conforto", "Infanto-juvenil", "Mountain Bike 29", "Mountain Bike 27", "Híbrida Urbana", "Speed"]

subcategories.each_with_index do |sub, index|
  subcategory = Subcategory.create(name: sub, active: true, category: category)
  item = Item.create(name: "item-#{sub}-#{index}", width: 10, subcategory: subcategory,  price: 100.50, weight: 10, length: 10, height: 10, active: true, description: "item-#{sub}-#{index}- lorem ipsum dolor sit ipsum moisle")
  puts "#{subcategory}"
end



puts "Acessórios"
category2 = Category.create(name: "Acessórios", active: true)
subcategories = ["Capacete", "Farol e lanterna", "Ferramentas", "Garrafinha e Suporte"]

subcategories.each_with_index do |sub, index|
  subcategory = Subcategory.create(name: sub, active: true, category: category2)
  item = Item.create(name: "item-#{sub}-#{index}", width: 10, subcategory: subcategory,  price: 100.50, weight: 10, length: 10, height: 10, active: true, description: "item-#{sub}-#{index}- lorem ipsum dolor sit ipsum moisle")
  puts "#{subcategory}"
end

puts "Vestuário"
category3 = Category.create(name: "Vestuário", active: true)
subcategories = ["Bermuda", "Calça", "Luva", "Colete", "Meia"]
subcategories.each_with_index do |sub, index|
  subcategory = Subcategory.create(name: sub, active: true, category: category3)
  item = Item.create(name: "item-#{sub}-#{index}", width: 10, subcategory: subcategory,  price: 100.50, weight: 10, length: 10, height: 10, active: true, description: "item-#{sub}-#{index}- lorem ipsum dolor sit ipsum moisle")
  puts "#{subcategory}"
end

puts "App info"
  app_info = AppInfo.create(id: 1)
  
