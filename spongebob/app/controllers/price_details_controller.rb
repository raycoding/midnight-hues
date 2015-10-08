class PriceDetailsController < ApplicationController
	skip_before_action :login_required, :authorize

	def index
		@price = PriceDetails.all
	end
end