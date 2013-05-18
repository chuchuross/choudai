# coding : utf-8

require 'rubygems'
require 'zipruby'

class ImageDownloader

  # @param [String] url
  # @param [String] path
  # @param [String] file_name
  # @param [Boolean] use_zip
  def self.download(url, path, file_name, use_zip)
    throw ArgumentError.new('URLと保存先のパスは必須です') if url == nil || path == nil
    FileUtils.mkdir_p(path) unless File.exist?(path)
    if use_zip
      save_as_zip(url, path, file_name)
    else
      save_as_file(url, path, file_name)
    end
  end

  # @param [String] url
  # @param [String] path
  # @param [String] file_name
  def self.save_as_zip(url, path, file_name)
    #TODO
  end
  private_class_method :save_as_zip

  # @param [String] url
  # @param [String] path
  # @param [String] file_name
  def self.save_as_file(url, path, file_name)
    save_path = File.join(path, file_name.to_s)
    open(save_path, 'wb') do |output|
      write_binary(url, output)
    end
  end
  private_class_method :save_as_file

  def self.write_binary(url, output)
    open(url) do |data|
      output.write(data.read)
    end
  end
  private_class_method :write_binary
end