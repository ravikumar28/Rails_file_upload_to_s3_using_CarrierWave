class ImageController < ApplicationController

	def image_post
		render :json => Image.create(:name => params["image"])
	end

end
