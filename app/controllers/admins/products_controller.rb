class Admins::ProductsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
      if @product.save
        redirect_to admins_product_path(@product.id)
      else
        redirect_to admins_products_path
      end

  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admins_product_path(@product.id)
    else
      redirect_to admins_product_path(@product.id)
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :genre_id, :image, :description, :price, :status)
  end
end

