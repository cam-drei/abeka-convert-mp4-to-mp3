require 'open-uri'
require 'fileutils'

@urls = %w{
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD001D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD002D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD003D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD004D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD005D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD007D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD008D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD009D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD010D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD011D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD012D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD013D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD014D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD016D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD017D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD018D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD019D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD021D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD022D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD023D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD026D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD027D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD028D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD030D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD031D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD032D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD033D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD036D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD037D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD038D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD041D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD042D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD043D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD046D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD047D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD048D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD050D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD051D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD052D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD054D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD055D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD056D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD057D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD058D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD059D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD060D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD061D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD062D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD063D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD066D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD067D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD068D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD069D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD071D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD072D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD073D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD074D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD075D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD076D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD077D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD078D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD080D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD081D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD082D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD083D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD086D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD087D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD088D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD090D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD091D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD092D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD093D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD095D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD096D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD097D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD098D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD100D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD101D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD102D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD103D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD104D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD105D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD106D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD107D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD108D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD109D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD110D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD111D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD112D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD113D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD114D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD115D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD116D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD117D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD118D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD119D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD120D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD121D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD122D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD123D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD124D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD125D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD126D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD127D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD128D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD129D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD130D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD131D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD132D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD133D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD134D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD135D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD137D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD138D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD139D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD140D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD141D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD142D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD143D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD144D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD145D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD146D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD147D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD148D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD149D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD150D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD151D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD152D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD153D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD154D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD155D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD156D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD157D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD158D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD159D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD160D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD161D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD162D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD163D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD164D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD165D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD166D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD167D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4SD168D_N2000.mp4
}

def named_mp4_files
  @mp4_files = {}
  @urls.each do |url|
    subject = url.sub('https://dt.homeschools.id.vn/Abeka/Video/K4/', '')
    subject = subject.sub('D_N2000', '')
    subject = subject.sub('K4SD', 'K4SD-')

    @mp4_files[subject] = url
  end
end

def download_mp4_files
  @mp4_files.each do |name, link|
    open("/Users/dungluu/thuydung/projects/abeka/convert-mp4-to-mp3/#{name}", 'wb') do |file|
      file << URI.open("#{link}").read
    end
  end
end

def convert_to_mp3
  `for i in *.mp4; do ffmpeg -i "$i" "${i%.*}.mp3"; done`
end

def cleanup_mp4_files
  FileUtils.rm Dir.glob('*.mp4')
end

# named_mp4_files
# download_mp4_files
convert_to_mp3
cleanup_mp4_files
