class ProductsController < ApplicationController
  before_action :set_product, only: [:destroy, :show, :edit, :update]

  def index
    @products = policy_scope(Product)
    @markers = @products.geocoded.map do |product|
      if product.category == 'Book'
        {
          lat: product.latitude,
          lng: product.longitude,
          infoWindow: render_to_string(partial: "info_window", locals: { product: product }),
          image_url: helpers.asset_url('book-black.png')
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

    # redirect_to products_path, notice: "Product was successfully created!"
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
    redirect_to products_path, notice: "Product was successfully deleted!"
  end

  private

  def product_params
    params.require(:product).permit(:title, :category, :description, :tags, :street, :zipcode, :city, :photo)
  end

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end
end
