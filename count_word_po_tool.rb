po_file = "po/en/viking_server.po"
skip_start_with = ['#', 'msgid']
total_count = 0
  File.open(po_file).each do |line|
    next if skip_start_with.select{|word| line.start_with?(word) }.count > 0

line = line.gsub('msgstr ', '').gsub(/%\{(.*)\}/, '')
    line.scan(/[a-zA-Z]+/) {|w| total_count = total_count + 1  }
    print " #{line}"
    p "TOTAL COUNT : #{total_count}"

  end

p "TOTAL COUNT : #{total_count}"

