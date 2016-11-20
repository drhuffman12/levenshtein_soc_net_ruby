require "fileutils"
require "benchmark"

module LevenshteinSocNetRuby
  class LsnBuilder
  end

  END_OF_INPUT = 'END OF INPUT'.freeze
  TRIM_EOL_REGEXP = /\r?\n/.freeze
  EXCLUDE_CHARS_REGEXP = /([^\u0000-\u007F]|\w)/.freeze # /[\s\_\'\-]/

  def initialize(input_file_path, max_lines = nil)
    @raw_words_list = []
    @clean_words_list = []
    @clean_word_lengths = []

    @raw_to_clean = {}
    @clean_to_raw = Hash.new([])

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

end