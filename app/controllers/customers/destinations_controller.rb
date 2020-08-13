class Customers::DestinationsController < ApplicationController
	before_action :authenticate_customer!

	def index
		@destinations = Destination.where(customer_id: current_customer.id)
		@destination = current_customer.destinations.new
	end

    def create
    	@destination = current_customer.destinations.new(destination_params)
    	if @destination.save
    	    redirect_to destinations_path
    	else
    		redirect_to root_path
    	end
    end

	def edit
		@destination = Destination.find(params[:id])
	end

	def update
		@destination = Destination.find(params[:id])
		if @destination.update(destination_params)
		redirect_to destinations_path
	    else
	    redirect_to root_path
		end
	end

	def destroy
		destination = Destination.find(params[:id])
		destination.destroy
		redirect_to destinations_path
	end

	private

		def destination_params
			params.require(:destination).permit(:postcode, :address, :name)
		end

end