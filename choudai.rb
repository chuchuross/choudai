# coding : utf-8

require 'uri'
require 'optparse'
require 'ruby-progressbar'
require './image_parser'
require './image_downloader'

use_zip = false
show_help = false
url = nil
path = nil

OptionParser.new do |option|
  # option.on('-z') { use_zip = true }
  option.on('-h') { |value| show_help = value }
  option.on('-l URL') { |value| url = value }
  option.on('-p PATH') { |value| path = value }
  option.parse!(ARGV)
end

if show_help
  puts <<-"EOS"
 -l <URL> 取得先のURLを指定します
 -p <path> 保存先のパスを指定します
 -h ヘルプを表示します
  EOS
  exit
end

begin
  raise ArgumentError.new('保存先のパスを指定してください -h でヘルプ') if path == nil
  image_parser = ImageParser.new
  image_url_list = image_parser.parseFromUrl(URI.parse(url))
  if image_url_list.length <= 0
    puts '取得できる画像がありませんでした'
    exit
  end
  progress_bar =ProgressBar.create(:format => '%a |%b>>%i| %p%% %t', :total => image_url_list.length)
  image_url_list.each do |image_url|
    ImageDownloader::download(image_url, path, File.basename(image_url), use_zip)
    progress_bar.increment
  end
rescue URI::InvalidURIError
  puts 'URLの形式が正しくないか入力されてない可能性があります -l <URL> で指定'
rescue
  puts '画像の取得に失敗しました'
end