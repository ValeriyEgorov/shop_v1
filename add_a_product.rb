# Настала пора дописать к нашему магазину программу,
# которая будет записывать новый товар в XML-список товаров.
#
# Напишите программу, которая спрашивает у пользователя, какой продукт он хочет добавить
# и в зависимости от выбора просит у него дополнительно ввести соответствующие поля.
#
# Этот код необходим только при использовании русских букв на Windows
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

current_path = File.dirname(__FILE__)

require current_path + '/lib/product.rb'
require current_path + '/lib/book.rb'
require current_path + '/lib/film.rb'

puts "Какой товар вы хотите добавить?"

choice = -1

until choice != '' && choice.to_i.between?(0, (Product.product_types.size - 1))

  Product.product_types.each_with_index do |item, index|
    puts "#{index}: #{item}"
  end

  choice = STDIN.gets.chomp

  if choice != '' && choice.to_i.between?(0, (Product.product_types.size - 1))
  else
    puts "Такого товара нет! Выберите какой товар вы хотите добавить!"
  end

end

product = Product.product_types[choice.to_i].read_from_console

product.save_to_xml(current_path + "/data/production.xml")

puts "Вы успешно добавили товар:"
puts product
