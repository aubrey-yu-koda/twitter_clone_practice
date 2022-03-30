class ImageUploader < CarrierWave::Uploader::Base
    # Include RMagick or MiniMagick support:
    include CarrierWave::RMagick
    include CarrierWave::MiniMagick
    include CarrierWave::Video
    include CarrierWave::Video::Thumbnailer
    include CarrierWave::FFmpeg

    # process encode_video: [:mp4, callbacks: { after_transcode: :set_success } ]

    # Choose what kind of storage to use for this uploader:
    storage :file
    # storage :fog
  
    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    version :video, :if => :video? do
      process :encode
    end
    # Provide a default URL as a default if there hasn't been a file uploaded:
    # def default_url(*args)
    #   # For Rails 3.1+ asset pipeline compatibility:
    #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    #
    #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    # end
  
    # Process files as they are uploaded:
    # process scale: [200, 300]
    #
    # def scale(width, height)
    #   # do something
    # end
  
    # Create different versions of your uploaded files:
    # version :thumb do
    #   process resize_to_fit: [50, 50]
    # end

    # version :thumb do
    #   process thumbnail: [{format: 'jpg', quality: 8, size: 360, logger: Rails.logger}]
    #   def full_filename for_file
    #       jpg_name for_file, version_name
    #   end
    # end

    # version :medium do
    #   process thumbnail: [{format: 'jpg', quality: 85, size: 300, logger: Rails.logger}]
    #   def full_filename for_file
    #       jpg_name for_file, version_name
    #   end
    # end

    def encode
      video = FFMPEG::Movie.new(@file.path)
      video_transcode = video.transcode(@file.path)
    end

    version :image,:if => :image? do
      process :resize_to_fit => [740, 300]
    end

    def jpg_name for_file, version_name
        %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.jpg}
    end

    # Add an allowlist of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    def extension_allowlist
      %w(jpg jpeg gif png mov mp4 mov avi mkv 3gp mpg mpeg)
    end
  
    # Override the filename of the uploaded files:
    # Avoid using model.id or version_name here, see uploader/store.rb for details.
    # def filename
    #   "something.jpg" if original_filename
    # end

    protected
    def image?(new_file)
         new_file.content_type.include? 'image'
    end
    
    def video?(new_file)
        new_file.content_type.include? 'video'
    end
  end
  