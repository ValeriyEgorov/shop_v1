#Класс Книга - отнаследован от класса продукт
class Book < Product
  #Конструктор класса - используется конструктор от класса Продукт
  # + дополнительные параметры: название, жанр и автор
  def initialize(params)
    super
    @name = params[:name]
    @genre = params[:genre]
    @author = params[:author]
  end

#Добавим геттеры класса
  attr_accessor(:name, :genre, :author)

  #  метод возвращающий информация о данном классе
  def to_s
    return  "Книга «#{@name}», #{@genre}, автор — #{@author}, #{super}"
  end

  def update(params)
    super
    @name = params[:name] if params[:name]
    @genre = params[:genre] if params[:genre]
    @author= params[:author] if params[:author]
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

    self.new(name: f[0], genre: f[1],author: f[2], price: f[3].to_i, count: f[4].to_i)

  end

  def self.read_from_console

    super

    puts "Укажите название книги"
    @name = STDIN.gets.chomp

    puts "Укажите автора книги"
    @author = STDIN.gets.chomp

    puts "Укажите жанр книги"
    @genre = STDIN.gets.chomp

    return self.new(count: @count, price: @price, name: @name, author: @author, genre: @genre)
  end


  def to_xml

    element = super

    book = element.add_element("book")
    book.attributes["title"] = @name
    book.attributes["author_name"] = @author
    book.attributes["genre"] = @genre

    return element
  end

end