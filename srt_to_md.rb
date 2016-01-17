##
# Outputs a directory of .srt transcription files to a markdown document. Used
# for Udacity online courses.
#
# Usage
# `ruby srt_to_md.rb "P1L2 Text Browser Exercise (Analysis) Subtitles"`


fail ArgumentError, 'Specify a directory of SRT files as an argument' if ARGV[0].nil?

directory = ARGV[0]
heading = directory.gsub(' Subtitles', '')
srt_files = File.join(directory, '*.srt')

File.open("#{heading}.md", 'w') do |wr_file|
  wr_file.write("# #{heading}\n\n")
  Dir.glob(srt_files).each do |file|
    wr_file.write("## #{file.gsub(directory + '/', '').gsub('.srt', '')}\n")
    text = File.read(file)
    ## Remove transcript times and line feeds/returns
    removed = text.gsub(/\d\:\d{2}\:\d{2}\.\d{3},\d\:\d{2}\:\d{2}.\d{3}/, '')
      .gsub(/\d{2}:\d{2}\:\d{2},\d{3} --> \d{2}\:\d{2}\:\d{2},\d{3}/, '')
      .gsub(/\d{1,}\n/, '')
      .gsub(/\r/, '').gsub(/\n/, ' ')
      .gsub(/\s\s/, '')
    wr_file.write("#{removed}\n")
  end
end
