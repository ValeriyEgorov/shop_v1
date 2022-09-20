class ProductCollection

  PRODUCT_TYPES = {
    film: { dir: 'films', class: Film },
    book: { dir: 'books', class: Book }
  }

  def initialize(products)
    @products = products
  end

  def to_a
    @products
  end

  def self.from_dir(dir_path)
    products = []

    PRODUCT_TYPES.each do |type, hash|
      dir_name = dir_path + "/" + hash[:dir] + "/*.txt"
      puts dir_name
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
      @products.sort_by! { |product| product.to_s}
    when :price
      @products.sort_by! { |product| product.price}
    when :count
      @products.sort_by! { |product| product.count}
    end

    @products.reverse! if params[:order] == :asc

    self
  end
end