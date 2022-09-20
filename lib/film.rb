#Класс Фильм - отнаследован от класса продукт

class Film < Product

  #Конструктор класса - используется конструктор от класса Продукт
  # + дополнительные параметры: название, год и режиссер
  def initialize(params)
    super
    @name = params[:name]
    @year = params[:year]
    @author = params[:author]
  end

  #Добавим геттеры класса
  attr_accessor(:name, :year, :author)

  #  метод возвращающий информация о данном классе
  def to_s
    return "Фильм «#{@name}», #{@year}, реж. #{@author}, #{super}"
  end

  def update(params)
    super
    @name = params[:name] if params[:name]
    @year = params[:year] if params[:year]
    @author = params[:author] if params[:author]
  end

  def self.from_file(file_path)
    begin
      file = File.new(file_path, "r:UTF-8")
      f = file.readlines
      file.close
      f.each do |line|
        line.chomp!
      end
    rescue SystemCallError
      puts "Файл не найден или к нему нет доступа, проверьте файл #{file_path}"
      return
    end

    self.new(name: f[0], author: f[1], year: f[2], price: f[3].to_i, count: f[4].to_i)

  end

end