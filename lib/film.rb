#Класс Фильм - отнаследован от класса продукт

class Film < Product

  #Конструктор класса - используется конструктор от класса Продукт
  # + дополнительные параметры: название, год и режиссер
  def initialize(params)
    super
    @name = params[:name]
    @year = params[:year]
    @author= params[:author]
  end

  #Добавим геттеры класса
  attr_reader(:name, :year, :author)

  #  метод возвращающий информация о данном классе
  def to_s
    return "Фильм «#{@name}», #{@year}, реж. #{@author}, #{super}"
  end

end