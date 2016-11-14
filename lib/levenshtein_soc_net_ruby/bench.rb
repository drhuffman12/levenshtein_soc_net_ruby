require "fileutils"
require "benchmark"

module LevenshteinSocNetRuby
  class Bench

    def initialize(max_words_sizes)
      if max_words_sizes && !max_words_sizes.empty?
        @max_words_sizes = max_words_sizes
      else
        # @max_words_sizes = [10,21]
        # @max_words_sizes = [10,21,42,83]
        # @max_words_sizes = [10,21,42,83,83*2,83*4]
        # @max_words_sizes = [10,21,42,83,83*2,83*4,83*8,83*16]
        # @max_words_sizes = [10,21,42,83,83*2,83*4,83*8,83*16,83*32,83*64]
        # @max_words_sizes = [10,21,42,83,83*2,83*4,83*8,83*16,83*32,83*64,83*128,83*256]
        @max_words_sizes = [10,21,42,83,83*2,83*4,83*8,83*16,83*32,83*64,83*128,83*256,83*512,83*1024]
      end
      @max_words_sizes.freeze
      @rwls = []
    end

    def run_all
      raw_word_list
    end

    def raw_word_list
      Benchmark.bm do |x|
        @max_words_sizes.each do |max_words|
          x.report("max_words: #{max_words} ") {
            @rwls << RawWordList.new(INPUT_FILE_PATH, max_words)
          }
        end
      end
      unless @rwls.empty?
        LOG.warn
        @rwls.each do |rwl|
          LOG.warn "#{rwl.counts.inspect}\n"
        end
      end
    end
  end
end