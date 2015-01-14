module PostsHelper


		def google_maps(address)
			address = address.gsub " ","+"
			map_api = ENV["GOOGLE_MAP_API"]
			@map = "https://www.google.com/maps/embed/v1/place?key=#{map_api}&q=#{address}"
  	end
	

end
