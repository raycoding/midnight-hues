require 'open-uri'
module LatLongFinder
	def find_latitude_longtide(str)
		begin
			address = URI::encode(str)
			url = URI.parse("http://maps.googleapis.com/maps/api/geocode/json?address=#{address}&sensor=false")
			req = Net::HTTP::Get.new(url.request_uri)
			res = Net::HTTP.start(url.host, url.port) {|http| http.request(req) }
			output = JSON.parse(res.body)
			if output.blank? or output["status"]!="OK" or output["results"].blank? or output["results"].first.blank? or output["results"].first["geometry"].blank? or output["results"].first["geometry"]["location"].blank?
				return nil
			else
				location_ll = output["results"].first["geometry"]["location"]
				latitude = location_ll["lat"]
				longtitude = location_ll["lng"]
				return nil if latitude.blank? or longtitude.blank?
				latitude = latitude.to_f.round(5)
				longtitude = longtitude.to_f.round(5)
				return [latitude,longtitude]
			end	
		rescue => e
			return nil
		end
	end
end