class SearchController < ApplicationController
  def search
  	@model = params["search"]["model"]
  	@content = params["search"]["content"]
  	@record = search_for(@model, @content)
  end

  private
  	def search_for(model, content)
  		if model == 'customer'
  			Customer.where(['family_name LIKE ? OR first_name LIKE ? OR family_name_ruby LIKE ? OR first_name_ruby LIKE ?', "%#{content}%", "%#{content}%", "%#{content}%", "%#{content}%"])
        # Customer.where('first_name LIKE ?', '%'+content+'%')
        # Customer.where('family_name_ruby LIKE ?', '%'+content+'%')
        # Customer.where('first_name_ruby LIKE ?', '%'+content+'%')
  		elsif model == 'product'
  			Product.where('name LIKE ?', '%'+content+'%')
  		end
  	end
end
