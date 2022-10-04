# Класс продукт
class Product

  #Сеттеры класса
  attr_accessor(:price, :count)

  def self.product_types
    return [Book, Film]
  end

  #Конструктор класса - принимает на вход ассоциативный массив
  def initialize(params)
    @price = params[:price]
    @count = params[:count]
  end

  #  метод возвращающий информация о данном классе
  def to_s
    return "#{price} руб. (осталось #{count})"
  end

  def update(params)
    @price = params[:price] if params[:price]
    @count = params[:count] if params[:count]
  end

  def self.from_file(file_path)
    raise NotImplementedError
  end

  def buy
    if @count > 0
      puts "Вы купили товар!"
      @count -= 1
      return @price
    else
      puts "К сожалению больше нет!"
      return 0
    end
  end

  def self.read_from_console
    puts "Укажите стоимость продукта в рублях"
    @price = STDIN.gets.to_i

    puts "Укажите, сколько единиц продукта осталось на складе"
    @count = STDIN.gets.to_i

  end

  def to_xml
    element = REXML::Element.new('product')
    element.attributes["price"] = @price
    element.attributes["amount_available"] = @count
    return element
  end

  def save_to_xml(file_name)

    unless File.exist?(file_name)
      abort "Хмл файл не найден"
    end

    file = File.new(file_name, "r:UTF-8")
    doc = REXML::Document.new(file)
    file.close

    file = File.new(file_name, "w:UTF-8")
    doc.root.add_element(self.to_xml)
    doc.write(file, 2)
    file.close

  end
end