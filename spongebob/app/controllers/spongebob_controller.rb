class SpongebobController < ApplicationController
	skip_before_action :login_required, :authorize
end