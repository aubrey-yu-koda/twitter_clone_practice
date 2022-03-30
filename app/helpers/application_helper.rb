module ApplicationHelper
    def file_type(filename)
        types = {
          :jpeg => "image",
          :jpg => "image",
          :gif => "image",
          :png => "image",
          :mov => "video",
          :mp4 => "video", 
          :mkv => "video",
          :avi => "video",
          :mpg => "video",
          :mpeg => "video"
        }
        types[filename.split(".").last.to_sym]
     end
end
