
module LevenshteinSocNetRuby
  class RawWordList
    # Note: I am assuming that a RawWordList instance could have duplicate 'raw' words (but no blank words).
    #   (We want to keep the soc net report words lined up with the input words.)
    #   However, the associated CleanWordList instance should not have any duplicate 'clean' words.

    END_OF_INPUT = 'END OF INPUT'.freeze
    EXCLUDE_CHARS_REGEXP = /[\s\_\'\-]/

    attr_reader :test, :clean_words, :meta

    def initialize(input_file_path, max_lines = nil)
      @test = []
      @meta = {}
      @clean_words = []

      load(input_file_path, max_lines)
    end

    def self.raw_to_clean(word)
      word.gsub(EXCLUDE_CHARS_REGEXP,'')
    end

    def all
      @meta.keys
    end

    def to_hash
      {test: @test, all: all, meta: @meta}
    end

    def inspect
      to_hash.inspect
    end

    def counts
      {raw_qty: meta.keys.size, test_qty: test.size, clean_qty: clean_words.size}
    end

    private

    def load(input_file_path, max_lines)
      lines = File.read(input_file_path).split(/\r?\n/).reject{|n| n.nil? || n.empty?}
      if !(lines.nil? || lines.empty?)
        len = lines.length
        max = max_lines.nil? || max_lines >= len ? len : max_lines
        found_END_OF_INPUT = false

        (0...max).each do |i|
          raw_word = lines[i].chomp # remove line endings
          at_END_OF_INPUT = (raw_word == END_OF_INPUT)
          found_END_OF_INPUT ||= at_END_OF_INPUT
          is_test_case = !found_END_OF_INPUT
          unless at_END_OF_INPUT
            add(raw_word, is_test_case)
          end
        end
        @clean_words.uniq!
      else
        msg = "Empty input file"
        raise msg
      end
    end

    def add(word, is_test = false)
      @test << word if is_test
      clean_word = self.class.raw_to_clean(word)
      @clean_words << clean_word
      @meta[word] = {raw_length: word.length, clean_length: clean_word.length, clean_word: clean_word}
    end
  end
end
