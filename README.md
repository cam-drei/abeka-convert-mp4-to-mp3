### install if not exist:
- Install Homebrew:
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- Install ffmpeg for convert_file_to_mp3:
  ```
  brew install ffmpeg
  ```
### Use:
Run ruby file in Terminal with syntax:
- For download abeka_k4_language_development mp3 files:
  By default, it will create directory folder with name "language-development" to contain files in current folder.
  ```
  ruby abeka_k4_language_development_mp4_to_mp3.rb
  ```

- For download abeka_k4_language_development mp3 files:
  By default, it will create directory folder with name "skill-development" to contain files in current folder.
  ```
  ruby abeka_k4_skill_development_mp4_to_mp3.rb
  ```

### Introduce: this file convert video to mp3 by steps
1. named_mp4_files:
- Increase the day in link (from 001 to 170) will get the video corresponding:
  urls = Array.new(170) {|index| "https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD#{format('%03d', (index+1) % 1000)}D_N2000.mp4" }

  ex: Day 1 with key 001 in link: https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD001D_N2000.mp4

- Rename file from url and put them to a hash:
  ex: https://dt.homeschools.id.vn/Abeka/Video/K4/K4LD001D_N2000.mp4 ===> K4LD-001.mp4
  (K4: abeka k4, LD: Language Development, 001: Day 1)

2. download_mp4_files
3. convert_to_mp3
4. cleanup_mp4_files
