# 
# @author: tidusvn05
# To count english word in list dir
#

dirs = ['website', 'website/about', 'website/guide']

total_count = 0
dirs.each do |dir|
  next if dir == ''
  list_file = Dir.entries(dir)
  total_count_dir = 0
  list_file.each do |file|
    full_file_path = dir + '/' + file
    next if file == '.' or file == '..' or File.directory?(full_file_path)
    file_contents = File.read( full_file_path)
    p "read content file #{file}"
    file_word_count = 0
    file_contents.scan(/[a-zA-Z]+/) {|w| file_word_count = file_word_count + 1  }
    p "Count words file #{full_file_path}: #{file_word_count}"
    total_count_dir = total_count_dir + file_word_count
  end
  p "TOTAL COUNT WORDS IN DIR:#{dir}: #{total_count_dir}"
  total_count = total_count + total_count_dir
end

p "TOTAL COUNT : #{total_count}"
