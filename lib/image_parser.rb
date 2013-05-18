# coding : utf-8

require 'nokogiri'
require 'open-uri'

class ImageParser
  # @param [URI] uri
  # @return [Array] image url string array
  def parse_from_url(uri)
    image_url_list = Array.new
    document = Nokogiri::HTML(open(uri))
    document.css('a[href $= ".jpg"], a[href $= ".jpeg"], a[href $= ".gif"], a[href $= ".png"]').each do |result|
      image_url_list << result.attribute('href')
    end
    return image_url_list
  end
end