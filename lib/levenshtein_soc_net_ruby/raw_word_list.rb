class RawWordList
  END_OF_INPUT = 'END OF INPUT'.freeze
  EXCLUDE_CHARS = ["\n","\r","'","-"," "] # ["\n","\r"] # ["\n","\r","'"]

  attr_reader :test, :meta

  def initialize(input_file_path, max_lines = nil)
    @test = []
    @meta = {}

    # load up data:
    lines = File.read(input_file_path).lines
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
    else
      msg = "Empty input file"
      # puts msg
      raise msg
    end
  end

  # def load(input_file_path, max_lines)
  # end

  def add(word, is_test = false)
    unless all.include?(word)
      @test << word if is_test
      clean_word = self.class.raw_to_clean(word)
      @meta[word] = {raw_length: word.length, clean_length: clean_word.length, clean_word: clean_word}
    else
      msg = "RawWord already exists for word: '#{word}'"
      puts msg
      # raise msg
    end
    @meta[word]
  end

  def all
    @meta.keys
  end

  def self.raw_to_clean(word)
    word.gsub(/[\s\_\'\-]/,'')
  end

  def to_hash
    {test: @test, all: all, meta: @meta}
  end

  def inspect
    to_hash.inspect
  end
end
