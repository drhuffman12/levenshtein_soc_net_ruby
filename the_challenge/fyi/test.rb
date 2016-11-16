letters = {}
syms = {}

# file = File.read('the_challenge/input.txt', encoding: 'iso-8859-1')
file = File.read('../input.txt')
file.each_line do |line|
  begin
    chars = line.gsub(/\r?\n/,'').split('')
    chars.each do |char|
      if char.match(/([^\u0000-\u007F]|\w)/)
        letters[char] ||= 0
        letters[char] += 1
      else
        syms[char] ||= 0
        syms[char] += 1
      end
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
  report_lines << "  i, letter, qty"
  sorted_hash = hist.sort_by{|k, v| [-1 * v, k] }.to_h
  sorted_hash.keys.each_with_index {|k,i| report_lines << " #{'%2s' % i}, '#{k}', #{"%5s" % hist[k]}"}
  report_lines
end

report_lines = rpt("letters:", letters) + rpt("symbols:", syms)
File.open('test.out', 'w') {|f| f.write(report_lines.join("\n")) }
