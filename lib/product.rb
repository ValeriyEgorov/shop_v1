# Класс продукт
class Product

  #Сеттеры класса
  attr_accessor(:price, :count)

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

end