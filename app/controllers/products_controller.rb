class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end


  def create
    @product = Product.new(product_params)
    @product.user = current_user

    @product.save

    redirect_to products_path, notice: "Product was successfully created!"
    # redirect_to @product, notice: "Product was successfully created!"
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "Product was successfully destroy!"
  end

  private

  def product_params
    params.require(:product).permit(:title, :category, :description, :tags, :street, :zpicode, :city)
  end

end
