require 'open-uri'
require 'fileutils'

def named_mp4_files
  @mp4_files = {}

  urls = Array.new(170) {|index| "https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD#{format('%03d', (index+1) % 1000)}D_N2000.mp4" }
  urls.each do |url|
    subject = url.sub('https://dt.homeschools.id.vn/Abeka/Video/K4/', '')
    subject = subject.sub('D_N2000', '')
    subject = subject.sub('K4LD', 'K4LD-')

    @mp4_files[subject] = url
  end
end

def download_mp4_files
  @directory_name = 'language-development'
  if !File.exists?(@directory_name)
    FileUtils.mkdir(@directory_name)
  else
    FileUtils.rm_rf(Dir.glob("#{@directory_name}/*"))
  end

  @mp4_files.each do |name, link|
    open("#{@directory_name}/#{name}", 'wb') do |file|
      file << URI.open("#{link}").read
    end
  end
end

def convert_to_mp3
  Dir.chdir("#{@directory_name}") { `for i in *.mp4; do ffmpeg -i "$i" "${i%.*}.mp3"; done` }
end

def cleanup_mp4_files
  FileUtils.rm Dir.glob("#{@directory_name}/*.mp4")
end

named_mp4_files
download_mp4_files
convert_to_mp3
cleanup_mp4_files
