class ProductsController < ApplicationController
  before_action :set_product, only: [:destroy, :show, :edit, :update]

  def index
    # @products = policy_scope(Product)

    if params[:query].present?
      @products = policy_scope(Product).search_by(params[:query]).where(status: "available")
      @count = @products.count
      count_products(@products)
    else
      @products = policy_scope(Product).where(status: "available")
      @count = @products.count
      count_products(@products)
    end

    if params[:category].present?
      @products = @products.where(category:params[:category])
      @count = @products.count
      count_products(@products)
    end

    @markers = @products.geocoded.map do |product|
      if product.category == 'Book'
        {
          lat: product.latitude,
          lng: product.longitude,
          infoWindow: render_to_string(partial: "info_window", locals: { product: product }),
          image_url: helpers.asset_url('book.png')
        }
      else
        {
          lat: product.latitude,
          lng: product.longitude,
          infoWindow: render_to_string(partial: "info_window", locals: { product: product }),
          image_url: helpers.asset_url('puzzle-piece.png')
        }
      end
    end
  end

  def new
    @product = Product.new
    authorize @product
  end

  def show
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    authorize @product

    @product.save

    redirect_to @product, notice: "Product was successfully created!"
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully update"
    else
      render :new
    end
  end

  def destroy
    @product.destroy
    redirect_to my_dashboard_path, notice: "Product was successfully deleted!"
  end

  private

  def product_params
    params.require(:product).permit(:title, :category, :description, :tags, :street, :zipcode, :city, :status, :photo)
  end

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end

  def count_products(products)
    @puzzles = []
    @books = []
    products.each do |product|
      case product.category
      when "Puzzle"
        @puzzles << product
      else
        @books << product
      end
    end
    @book_count = @books.count
    @puzzle_count = @puzzles.count
  end
end
