# encoding: UTF-8
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

#Подключаем классы
require_relative 'lib/product'
require_relative 'lib/film'
require_relative 'lib/book'

products = []
products << Film.new(price: 290, count: 5, name: "Леон", year: 1994, author:"Люк Бессон")
products << Film.new(price: 390, count: 1, name: "Дурак", year: 2014, author:"Юрий Быков")
products << Book.new(price: 1500, count: 10, name: "Идиот", genre: "роман", author:"Федор Достоевский")
products << Product.new(price: 777, count: 99)

products.each do |product|
puts product
end