#!/usr/bin/env ruby

require "bundler/setup"
require "fileutils"
require "benchmark"
require "ruby-prof"
require "levenshtein_soc_net_ruby"

class Profiler
  def initialize(max_words_sizes)
    # @sub_path = sub_path
    @max_words_sizes = max_words_sizes #.to_s.split(",").collect{|p| p.to_i}
    # if @max_words_sizes && !@max_words_sizes.empty?
    #   @max_words_sizes = @max_words_sizes.split(",").collect{|p| p.to_i}
    # else
    #   # @max_words_sizes = [10,21]
    #   # @max_words_sizes = [10,21,42,83]
    #   # @max_words_sizes = [10,21,42,83,83*2,83*4]
    #   # @max_words_sizes = [10,21,42,83,83*2,83*4,83*8,83*16]
    #   # @max_words_sizes = [10,21,42,83,83*2,83*4,83*8,83*16,83*32,83*64]
    #   # @max_words_sizes = [10,21,42,83,83*2,83*4,83*8,83*16,83*32,83*64,83*128,83*256]
    #   @max_words_sizes = [10,21,42,83,83*2,83*4,83*8,83*16,83*32,83*64,83*128,83*256,83*512,83*1024]
    # end
  end

  def print_prof_rpt_graph(folder, results)
    file_graph = File.open(folder + "/profiler.GraphPrinter.out",'w')
    RubyProf::GraphPrinter.new(results).print(file_graph, {})
  end

  def print_prof_rpt_call_tree(folder, results)
    RubyProf::CallTreePrinter.new(results).print({path: folder})
    # File.open File.expand_path(file_path), 'w' do |file|
    #   # File.open(folder + "/profiler.CallTreePrinter.out", 'w') do |file|
    #   # File.open(folder, 'w') do |file|
    #   RubyProf::CallTreePrinter.new(results).print({path: file})
    # end
  end

  def profile_folder
    # (@sub_path ? @sub_path : LevenshteinSocNetRuby::LOG.folder) + "/" + "#{@max_words_sizes.first}_to_#{@max_words_sizes.last}"
    # (@sub_path ? @sub_path : LevenshteinSocNetRuby::LOG.folder)
    # LOG = ::Logger.new(File.open("log/#{Time.now.strftime("%Y_%m_%d")}/app_#{Time.now.strftime("%H-%M-%S")}.log", "a"))
    "log/#{Time.now.strftime("%Y_%m_%d")}"
  end

  def log_results(results)
    results.eliminate_methods!([/Benchmark/])
    # results.eliminate_methods!([/Bench/])
    folder_path = profile_folder
    FileUtils.mkdir_p(folder_path) unless File.exists?(folder_path)
    print_prof_rpt_call_tree(folder_path, results)
    print_prof_rpt_graph(folder_path, results)
  end

  def run
    LevenshteinSocNetRuby::LOG.warn "profile(sub_path, *params) -> params: #{@params || '(nil)'}, @max_words_sizes: #{@max_words_sizes}"
    results = nil
    RubyProf.start
    test
    results = RubyProf.stop
    if results
      log_results(results)
    end
  end

  def test
    b = LevenshteinSocNetRuby::Bench.new(@max_words_sizes)
    LevenshteinSocNetRuby::LOG.warn b.inspect
    b.run_all
  end
end


# main
# LevenshteinSocNetRuby::LOG.warn "Profile -> ARGV: #{ARGV}"
LevenshteinSocNetRuby::LOG.warn "Profile -> ARGV: #{ARGV}"
# sub_path = ARGV[0] || 'profile'
params = ARGV[0].to_s.split(",").collect{|p| p.to_i}
profile = Profiler.new(params)
profile.run
