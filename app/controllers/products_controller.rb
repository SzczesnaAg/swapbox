class ProductsController < ApplicationController
  def index
    @products = Product.all
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
end
