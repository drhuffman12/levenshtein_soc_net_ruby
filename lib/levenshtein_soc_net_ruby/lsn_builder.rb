require "fileutils"
require "benchmark"

module LevenshteinSocNetRuby
  class LsnBuilder
    END_OF_INPUT = 'END OF INPUT'.freeze
    TRIM_EOL_REGEXP = /\r?\n/.freeze
    EXCLUDE_CHARS_REGEXP = /^([^\u0000-\u007F]|\w)/.freeze # /[\s\_\'\-]/

    def initialize(max_lines = nil, input_file_path = nil)
      @input_file_path = input_file_path || INPUT_FILE_PATH
      @max_lines = max_lines

      @raw_words_list = []
      @raw_test_words_list = []
      @clean_words_list = []
      @clean_word_lengths = []

      @raw_to_clean = {}
      @clean_to_raw = Hash.new {|h,k| h[k] = []} # ([])

      @clean_to_length = {}
      @length_to_clean = Hash.new([])

      @hist_to_length = {}
      @length_to_hist = Hash.new([])

      @clean_to_hist = {}
      @hist_to_clean = Hash.new([])

      @clean_to_friends = Hash.new([])

      @clean_to_soc_net_members = Hash.new([])

      # load(input_file_path, max_lines)
    end

    def run
      load
    end

    private

    def load
      lines = File.read(@input_file_path).split(/\r?\n/).reject{|n| n.nil? || n.empty?}
      if !(lines.nil? || lines.empty?)
        len = lines.length
        max = @max_lines.nil? || @max_lines >= len ? len : @max_lines
        found_END_OF_INPUT = false

        (0...max).each do |i|
          raw_word = lines[i].chomp # remove line endings
          at_END_OF_INPUT = (raw_word == END_OF_INPUT)
          found_END_OF_INPUT ||= at_END_OF_INPUT
          is_test_case = !found_END_OF_INPUT
          unless at_END_OF_INPUT
            map_raw_to_clean(raw_word, is_test_case)
          end
        end
        @clean_words_list.sort!.uniq!
        @clean_word_lengths.sort!.uniq!
      else
        msg = "Empty input file"
        raise msg
      end
    end

    def map_raw_to_clean(word, is_test = false)
      @raw_words_list << word
      @raw_test_words_list << word if is_test
      clean_word = trim_non_letters(word)
      @clean_words_list << clean_word
      @raw_to_clean[word] = clean_word
      @clean_to_raw[clean_word] << word
      @clean_word_lengths << clean_word.length
    end

    def trim_non_letters(word)
      word.split('').collect{|char| char if char.match(EXCLUDE_CHARS_REGEXP)}.reject{|n| n.nil? || n.empty?}.join
    end
  end
end

=begin

l = LevenshteinSocNetRuby::LsnBuilder.new(10)
l.run
l
#=> #<LevenshteinSocNetRuby::LsnBuilder:0x00000001e01f40 @input_file_path="the_challenge/input.txt", @max_lines=10, @raw_words_list=["horrid", "basement", "abbey", "recursiveness", "elastic", "macrographies", "a", "aardvark", "aardvark's"], @raw_test_words_list=["horrid", "basement", "abbey", "recursiveness", "elastic", "macrographies"], @clean_words_list=["a", "aardvark", "aardvarks", "abbey", "basement", "elastic", "horrid", "macrographies", "recursiveness"], @clean_word_lengths=[1, 5, 6, 7, 8, 9, 13], @raw_to_clean={"horrid"=>"horrid", "basement"=>"basement", "abbey"=>"abbey", "recursiveness"=>"recursiveness", "elastic"=>"elastic", "macrographies"=>"macrographies", "a"=>"a", "aardvark"=>"aardvark", "aardvark's"=>"aardvarks"}, @clean_to_raw={"horrid"=>["horrid"], "basement"=>["basement"], "abbey"=>["abbey"], "recursiveness"=>["recursiveness"], "elastic"=>["elastic"], "macrographies"=>["macrographies"], "a"=>["a"], "aardvark"=>["aardvark"], "aardvarks"=>["aardvark's"]}, @clean_to_length={}, @length_to_clean={}, @hist_to_length={}, @length_to_hist={}, @clean_to_hist={}, @hist_to_clean={}, @clean_to_friends={}, @clean_to_soc_net_members={}>

=end

