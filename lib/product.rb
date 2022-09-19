# Класс продукт
class Product

  #Сеттеры класса
  attr_reader(:price, :count)

  #Конструктор класса - принимает на вход ассоциативный массив
  def initialize(params)
    @price = params[:price]
    @count = params[:count]
  end

  #  метод возвращающий информация о данном классе
  def to_s
    return "#{price} руб. (осталось #{count})"
  end

end