require 'base64'

class ImageProcessing
  def initialize
  end

  def image_processing (image_name, image_format)
    image_path = File.dirname(File.dirname(__FILE__)) + '/app/assets/images/' \
                 + image_name + '.' + image_format

    image = open(image_path) { |f| f.read }
    image_base64 = Base64.encode64(image)
    return image_base64
  end

end
