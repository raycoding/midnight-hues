class PriceDetailsController < ApplicationController
	skip_before_action :login_required, :authorize

	def index
		PriceDetails.all
	end
end