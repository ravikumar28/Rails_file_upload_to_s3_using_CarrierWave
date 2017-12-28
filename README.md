# Upload files to S3 on Rails using CarrierWave 

### Installation

```rails g model image```

```rails g controller image```


Add required gems to your Gemfile

If you face any issues with rmagick, follow this steps:
	
	Uninstall existing imagemagick if needed

		```brew install imagemagick@6```

Since this is keg-only, you should then force-link it:

		```brew link --force imagemagick@6```

```
gem 'rmagick' , '2.13.2'
gem 'fog-aws'
gem 'fog'
gem 'net-ssh'
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
```

Carrierwave is the gem that allows image uploads, rmagick allows use to resize and crop images, and lastly "fog-aws" allows us to upload images to S3 with ease.


```
rails generate uploader image
```
	 
It will create ```app/uploaders/image_uploader.rb```. And add follwing lines to this file.


``` 
    include CarrierWave::RMagick
```

```
    storage :fog
```	
	
if you store your files in local system:
```
storage :file	
```


### To resize your image:
You can customize size and suffix name here.
```	
	version :thumb_2x do
    	process :resize_to_fill => [64,64]
  	end
  	version :medium do
    	process :resize_to_fill => [450,621]
  	end
```

### Set your is storage location here.
It will create folder structure like this =>  "<<modelname>>/file/<<model.id>>""
```
    def store_dir
    	"#{model.class.to_s.underscore}/file/#{("%04d" % model.id)}"
  	end
```	


In your model file ```app/models/image.rb```
Assign table field to store file reference
```	
	mount_uploader :name, ImageUploader
```
	

## S3 Configuration
Create file in config/initializer/carrierwave.rb, And paste following things with your S3 details.
```
	CarrierWave.configure do |config|
	  config.fog_credentials = {
	    provider:              'AWS',                        	# required
	    aws_access_key_id:     '<<Your AWS access Key>>',       # required
	    aws_secret_access_key: '<<Your AWS secret Key>>',       # required
	    region:                '<<region>>',                    # optional, defaults to 'us-east-1'
	  }      
	  config.fog_directory  = '<<Your AWS Bucket name>>'		# required
	  config.fog_public     = false                             # optional, defaults to true
	  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
	end

```


## For more Refer here:

	[a link](https://github.com/carrierwaveuploader/carrierwave)


