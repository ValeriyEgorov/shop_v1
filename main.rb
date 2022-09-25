# encoding: UTF-8
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

current_path = File.dirname(__FILE__)

#Подключаем классы
require_relative current_path + '/lib/product'
require_relative current_path + '/lib/film'
require_relative current_path + '/lib/book'
require_relative current_path + '/lib/productcollection'

products = []
products << Film.new(price: 290, count: 5, name: "Леон", year: 1994, author: "Люк Бессон")
products << Film.new(price: 390, count: 1, name: "Дурак", year: 2014, author: "Юрий Быков")
products << Book.new(price: 1500, count: 10, name: "Идиот", genre: "роман", author: "Федор Достоевский")
products << Product.new(price: 777, count: 99)
products << Film.from_file(current_path +'./data/films/01.txt')
products << Book.from_file(current_path + './data/books/01.txt')

begin
  products << Product.from_file(current_path + './data/books/01.txt')
rescue NotImplementedError
  puts 'Метод класса Product.from_file не реализован'
end
puts "Используем класс ProductCollection:"
products.each_with_index do |product, index|
  puts "Элемент масссива " + index.to_s + " " + product.to_s
end

puts "Используем класс ProductCollection:"
collection = ProductCollection.from_dir(current_path + "/data")

puts "Выведем все элементы ProductCollection"
collection.info

puts "\nОтсортируем по названию"
collection.sort!(by: :name)
collection.info
puts "\nОтсортируем по цене"
collection.sort!(by: :price)
collection.info

puts "\nОтсортируем по количеству"
collection.sort!(by: :count)
collection.info

puts "\nОтсортируем по цене в порядке возрастания"
collection.sort!(by: :price, order: :asc)
collection.info

#Реализуем метод покупки
puts "Что хотите купить?:"

#Выведем наши товары из хмл-файла
xml_collection = ProductCollection.read_from_xml(current_path + "./data/production.xml")

#Выведем ассортимент пользователю
xml_collection.each_with_index do |item, index|
  puts "#{index}. #{item}"
end

#Сохраним ввод пользователя
choice = -1
sum = 0

while choice != "x"
  choice = STDIN.gets.chomp
  if choice == "x"
    puts "Спасибо с вас: #{sum} рублей"
  elsif choice.to_i >= 0 && choice.to_i < xml_collection.size && choice != ''
    sum += xml_collection[choice.to_i].buy
  else
    puts "Нет такого товара!!!"
  end
end



