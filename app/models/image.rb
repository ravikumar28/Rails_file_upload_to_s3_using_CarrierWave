class Image < ActiveRecord::Base

	mount_uploader :name, ImageUploader
	
end
