require "levenshtein_soc_net_ruby/version"
require "levenshtein_soc_net_ruby/raw_word_list"
require "levenshtein_soc_net_ruby/bench"

module LevenshteinSocNetRuby
end

def main

  # max_words_sizes = [10,21]
  # max_words_sizes = [10,21,42,83]
  # max_words_sizes = [10,21,42,83,83*2,83*4]
  # max_words_sizes = [10,21,42,83,83*2,83*4,83*8,83*16]
  # max_words_sizes = [10,21,42,83,83*2,83*4,83*8,83*16,83*32,83*64]
  # max_words_sizes = [10,21,42,83,83*2,83*4,83*8,83*16,83*32,83*64,83*128,83*256]
  max_words_sizes = [10,21,42,83,83*2,83*4,83*8,83*16,83*32,83*64,83*128,83*256,83*512,83*1024]

  # profile = true
  profile = false # true # false
  # puts "ARGV: #{ARGV}"
  # b = Bench.new(ARGV[0] || max_words_sizes, ARGV[1] || profile)
  # b = Bench.new(ARGV[1]) || max_words_sizes, ARGV[2] || profile)
  b = Bench.new(max_words_sizes, profile)
  puts b.inspect
  b.run_all
  puts b.inspect

  # puts "1 " + "-"*80
  # puts "2 " + "-"*80
  # puts "3 " + "-"*80
  # puts "4 " + "-"*80

end

main if __FILE__ == $0
