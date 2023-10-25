### Use:
  After download ruby file, edit the path to your local in method "download_mp4_files"
  ex: open("/Users/dungluu/thuydung/projects/abeka/convert-mp4-to-mp3/#{name}", 'wb') do |file|
  ===> open("/Users/vinhluu/abeka/#{name}", 'wb') do |file|

### Introduce: this file convert video to mp3 by steps
1. named_mp4_files:
  Rename file from url and put them to a hash
  ex: https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD001D_N2000.mp4 ===> K4LD-001.mp4
  (K4: abeka k4, LD: Language Development, 001: Day 1)

2. download_mp4_files
3. convert_to_mp3
4. cleanup_mp4_files
