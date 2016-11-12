require "fileutils"
require "benchmark"
require "ruby-prof"
# require "levenshtein_soc_net_ruby"

class Bench
  INPUT_FILE_PATH = 'the_challenge/input.txt'.freeze
  DATETIME_FORMAT = '%Y/%m/%d/%H-%M-%S'.freeze

  def initialize(max_words_sizes, profile)
    @starting_at = Time.now.freeze
    @starting_at_str = @starting_at.strftime(DATETIME_FORMAT).freeze
    @max_words_sizes = max_words_sizes.freeze
    # @profile = profile.freeze
  end

  def run_all
    raw_word_list
  end

  def raw_word_list
    rwl = nil
    Benchmark.bm do |x|
      @max_words_sizes.each do |max_words|
        # puts "\n" + ("v"*80) + "\n"

        results = nil
        RubyProf.start if @profile
        x.report("max_words: #{max_words} ") {
          rwl = RawWordList.new(INPUT_FILE_PATH, max_words)
          # puts rwl.inspect if max_words == @max_words_sizes.last
        }
        results = RubyProf.stop if @profile

        # puts "\n" + ("v"*80) + "\n"

        # # generate CacheGrind performance data
        # if @profile && results
        #   # results.eliminate_methods!([/Benchmark/,/Bench/])
        #   results.eliminate_methods!([/Benchmark/])
        #   # results.eliminate_methods!([/Bench/])
        #   folder = profile_folder(max_words)
        #   FileUtils.mkdir_p(folder) unless File.exists?(folder)
        #   # print_prof_rpt_call_tree(folder, results, max_words)
        #   print_prof_rpt_graph(folder, results, max_words)
        # end
      end
    end
    puts "\n" + rwl.inspect + "\n"
  end

  # private
  #
  # def print_prof_rpt_graph(folder, results, max_words)
  #   file_graph = File.open(folder + "/profiler.GraphPrinter.out",'w')
  #   RubyProf::GraphPrinter.new(results).print(file_graph, {})
  # end
  #
  # def print_prof_rpt_call_tree(folder, results, max_words)
  #   File.open File.expand_path(folder), 'w' do |file|
  #   # File.open(folder + "/profiler.CallTreePrinter.out", 'w') do |file|
  #   # File.open(folder, 'w') do |file|
  #     RubyProf::CallTreePrinter.new(results).print({path: folder})
  #   end
  # end
  #
  # def profile_folder(max_words)
  #   folder = "log/profile/#{@starting_at_str}/#{max_words}"
  # end
end
