require 'open-uri'
require 'fileutils'

@urls = %w{
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD001D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD002D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD003D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD004D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD005D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD006D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD007D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD008D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD009D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD010D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD011D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD012D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD013D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD014D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD015D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD016D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD017D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD018D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD019D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD020D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD021D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD022D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD023D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD024D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD025D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD026D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD027D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD028D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD029D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD030D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD031D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD032D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD033D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD034D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD035D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD036D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD037D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD038D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD039D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD040D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD041D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD042D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD043D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD044D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD045D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD046D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD047D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD048D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD049D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD050D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD051D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD052D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD053D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD054D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD055D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD056D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD057D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD058D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD059D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD060D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD061D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD062D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD063D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD064D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD065D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD066D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD067D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD068D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD069D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD070D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD071D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD072D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD073D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD074D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD075D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD076D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD077D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD078D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD079D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD080D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD081D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD082D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD083D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD084D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD085D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD086D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD087D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD088D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD089D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD090D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD091D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD092D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD093D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD094D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD095D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD096D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD097D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD098D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD099D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD100D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD101D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD102D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD103D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD104D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD105D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD106D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD107D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD108D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD109D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD110D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD111D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD112D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD113D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD114D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD115D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD116D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD117D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD118D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD119D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD120D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD121D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD122D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD123D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD124D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD125D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD126D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD127D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD128D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD129D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD130D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD131D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD132D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD133D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD134D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD135D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD136D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD137D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD138D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD139D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD140D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD141D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD142D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD143D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD144D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD145D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD146D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD147D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD148D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD149D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD150D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD151D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD152D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD153D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD154D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD155D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD156D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD157D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD158D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD159D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD160D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD161D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD162D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD163D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD164D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD165D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD166D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD167D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD168D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD169D_N2000.mp4
  https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD170D_N2000.mp4
}

def named_mp4_files
  @mp4_files = {}
  @urls.each do |url|
    subject = url.sub('https://dt.homeschools.id.vn/Abeka/Video/K4/', '')
    subject = subject.sub('D_N2000', '')
    subject = subject.sub('K4LD', 'K4LD-')

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

named_mp4_files
download_mp4_files
convert_to_mp3
cleanup_mp4_files
