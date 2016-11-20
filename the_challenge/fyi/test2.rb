lines_counts = Hash.new(0)
trimmed_lines_counts = Hash.new(0)
untrimmed_lines_counts = Hash.new(0)

File.read('the_challenge/input.txt').lines.each do |line|
  begin
    trimmed_line = line.gsub(/\r?\n/,'')
    lines_counts[trimmed_line] += 1

    chars = trimmed_line.split('')
    word_trimmed = false
    chars.each do |char|
      # if char.match(/([^\x{0000}-\x{007F}]|\w)/)
      unless char.match(/([^\u0000-\u007F]|\w)/)
        word_trimmed = word_trimmed || true
      end
    end
    if word_trimmed
      trimmed_lines_counts[trimmed_line] += 1
    else
      untrimmed_lines_counts[trimmed_line] += 1
    end
  rescue => e
    puts
    puts "line: #{line}, error: #{e.message}"
    puts
  end
end

def rpt(title, hist)
  report_lines = []
  report_lines << title
  report_lines << "  i, word, qty"
  sorted_hash = hist.sort_by{|k, v| [-1 * v, k] }.to_h
  sorted_hash.keys.each_with_index {|k,i| report_lines << " #{'%2s' % i}, '#{'%-20s' % k}', #{"%5s" % hist[k]}"}
  report_lines
end

File.open('the_challenge/fyi/test2_lines.out', 'w') {|f| f.write(rpt("lines:", lines_counts).join("\n")) }
File.open('the_challenge/fyi/test2_untrimmed.out', 'w') {|f| f.write(rpt("untrimmed_words:", untrimmed_lines_counts).join("\n")) }
File.open('the_challenge/fyi/test2_trimmed.out', 'w') {|f| f.write(rpt("trimmed_words:", trimmed_lines_counts).join("\n")) }
