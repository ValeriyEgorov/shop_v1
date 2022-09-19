#Класс Книга - отнаследован от класса продукт
class Book < Product
  #Конструктор класса - используется конструктор от класса Продукт
  # + дополнительные параметры: название, жанр и автор
  def initialize(params)
    super
    @name = params[:name]
    @genre = params[:genre]
    @author= params[:author]
  end

#Добавим геттеры класса
  attr_reader(:name, :genre, :author)

  #  метод возвращающий информация о данном классе
  def to_s
    return  "Книга «#{@name}», #{@genre}, автор — #{@author}, #{super}"
  end

end