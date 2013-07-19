class Tool  

  #
  # To count english words in HTML files from dirs
  # Strip attribute words
  #
  def self.count_html
    require 'hpricot'

    dirs = ['/home/tandat/tmp/website', '/home/tandat/tmp/website/about', '/home/tandat/tmp/website/guide']

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
        doc = Hpricot(file_contents)
        file_word_count = doc.inner_text.split.uniq.count    

        p "Count words file #{full_file_path}: #{file_word_count}"
        total_count_dir = total_count_dir + file_word_count
      end
      p "TOTAL COUNT WORDS IN DIR:#{dir}: #{total_count_dir}"
      total_count = total_count + total_count_dir
    end
    p "TOTAL COUNT : #{total_count}"

  end


  #
  # To Count english word in Flex source: mxml and as file.
  #
  def self.count_flex
    dirs = ['/home/tandat/tmp/client']

    total_count = 0
    total_count = Tool.count_flex_in_dir(dirs[0]) 
    p "Total count : #{total_count}"
  end

  def self.count_flex_in_dir(dir)
     patterns = [
      ['headerText="', '"'], #<DataGridColumn
      ['label="', '"'], #<button
      ['text="', '"'], #<text
      [' = "', '"'],  #as variables
      ['toolTip="', '"'], #image
      ['Alert.show("','")'],  #alert
      [' += "', '"'],

    ]

    total_count = 0

    list_file = Dir.entries(dir)
      return false unless File.directory?(dir)
      total_count_dir = 0
      list_file.each do |file|
        full_file_path = dir + '/' + file

        next if file == '.' or file == '..'
        if File.directory?(full_file_path)
          p "\n\n\n"
          total_count_dir = total_count_dir + Tool.count_flex_in_dir(full_file_path)
          p "\n\n\n"
          next
        end

        file_contents = File.read( full_file_path)
	p "=" * 10
        p "---read content file #{full_file_path}---"
        file_word_count = 0
        patterns.each do |pat|
          texts = file_contents.scan(/#{pat[0]}([a-zA-Z0-9{}_:.\s]+)#{pat[1]}/)
          p "texts of #{pat[0]}: #{texts.inspect}"
          texts.each do |text|
            file_word_count = file_word_count + text[0].scan(/[a-zA-Z]+/).count
          end
        end

        total_count_dir = total_count_dir + file_word_count
        p "File count result is: #{file_word_count} "
        p "-" * 10
      end
      p "TOTAL COUNT WORDS IN DIR:#{dir}: #{total_count_dir}"
      p "#" * 10
      total_count = total_count + total_count_dir
    return total_count
  end


end
