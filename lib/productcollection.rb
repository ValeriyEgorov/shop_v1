require "rexml/document"

class ProductCollection

  PRODUCT_TYPES = {
    film: { dir: 'films', class: Film },
    book: { dir: 'books', class: Book }
  }

  def initialize(products)
    @products = products
  end

  def info
    @products.to_a.each_with_index do |item, index|
      puts "#{index}. #{item}"
    end
  end

  def self.from_dir(dir_path)
    products = []

    PRODUCT_TYPES.each do |type, hash|
      dir_name = dir_path + "/" + hash[:dir] + "/*.txt"
      class_name = hash[:class]

      Dir[dir_name].each do |path|
        products << class_name.from_file(path)
      end

    end
    self.new(products)
  end

  def sort!(params)
    case params[:by]
    when :name
      @products.sort_by! { |product| product.to_s }
    when :price
      @products.sort_by! { |product| product.price }
    when :count
      @products.sort_by! { |product| product.count }
    end

    @products.reverse! if params[:order] == :asc

    self
  end

  # Метод, который читает данные из хмл-файла
  # Входные параметры: путь к файлу
  def self.read_from_xml(file_path)

    #Инициалируем массив продуктов
    products = []

    #Проверим наличие хмл-файла
    unless File.exist?(file_path)
      abort "Хмл файл не найден!!!"
    end

    #Откроем файл и распарсим его с помощью библиотеки rexml
    file = File.new(file_path, "r:UTF-8")
    doc = REXML::Document.new(file)
    #Закрываем файл
    file.close

    #Пройдем в цикле по массиву всех продуктов с тегами */product
    doc.elements.each("products/product") do |item|
      #Запишем цену и количеству
      price = item.attributes['price'].to_i
      count = item.attributes['amount_available'].to_i

      #Пройдем в цикле по массиву каждого элемента book в продукте
      item.each_element("book") do |book|
        #Запишем остальные атрибуты
        name = book.attributes['title']
        genre = book.attributes['genre']
        author = book.attributes['author_name']
        #Создадим новый экземпляр класса Book и добавим его в массив наших продуктов
        products << Book.new(price: price, count: count, genre: genre, name: name, author: author)
      end

      #Повторим для каждого элемента film
      item.each_element("film") do |film|
        name = film.attributes['title']
        year = film.attributes['year']
        author = film.attributes['author_name']
        products << Film.new(price: price, count: count, year: year, name: name, author: author)
      end

    end

    #Создадим экземпляр класса ProductCollection.
    # Вызовем конструктов класса ProductCollection
    return products

  end
end