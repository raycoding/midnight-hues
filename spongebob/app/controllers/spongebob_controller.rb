class SpongebobController < ApplicationController
  acl_check :cal_login, :all_actions => :read
  skip_before_action :client_required, :only => [:change_client]
end