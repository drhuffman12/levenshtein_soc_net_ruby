letters = {}
syms = {}

# NOTE: for 'stable' sort (i.e.: where two values could be considered equal and you don't want to swap the order),
#   you have to do something like `arr.sort_by.with_index { |o, i| [o, i] }`
# See:
# * https://bugs.ruby-lang.org/issues/1089
# * https://github.com/crystal-lang/crystal/issues/2350"`

file = File.read('the_challenge/input.txt')
file.each_line do |line|
  begin
    chars = line.gsub(/\r?\n/,'').split('')
    chars.each do |char|
      # if char.match(/([^\x{0000}-\x{007F}]|\w)/)
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

report_lines = rpt("symbols:", syms) + rpt("letters:", letters)
File.open('the_challenge/fyi/test.out', 'w') {|f| f.write(report_lines.join("\n")) }
