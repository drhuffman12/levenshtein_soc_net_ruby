#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
# require "logger"

require "levenshtein_soc_net_ruby/version"
require "levenshtein_soc_net_ruby/logger"
require "levenshtein_soc_net_ruby/runner"
require "levenshtein_soc_net_ruby/raw_word_list"
require "levenshtein_soc_net_ruby/bench"
require "levenshtein_soc_net_ruby/lsn_builder"

module LevenshteinSocNetRuby
  INPUT_FILE_PATH = 'the_challenge/input.txt'.freeze
  # LOG_PATH = "log/#{Time.now.strftime("%Y_%m_%d")}"
  LOG = LevenshteinSocNetRuby::Logger.new.logger

  def self.main(max_words_sizes)
    # If max_words_sizes has more than one size, then we benchmark for each size; otherwise we just run for the one size
    LOG.warn "#{self.class.name} -> max_words_sizes: '#{max_words_sizes}'"
    max_words_sizes.size > 1 ? bench(max_words_sizes) : run(max_words_sizes.first)
  end

  def self.bench_old(max_words_sizes)
    b = LevenshteinSocNetRuby::Bench.new(max_words_sizes)
    LevenshteinSocNetRuby::LOG.warn b.inspect
    b.run_all
  end

  def self.bench(max_words_sizes)
    times = Benchmark.bm do |x|
      max_words_sizes.each do |max_words|
        x.report("max_words: #{max_words} ") {
          run(max_words)
        }
      end
    end
    LevenshteinSocNetRuby::LOG.warn times
  end

  def self.run_old(max_words)
    r = LevenshteinSocNetRuby::Runner.new(max_words)
    LevenshteinSocNetRuby::LOG.warn r.inspect
    r.run
  end

  def self.run(max_words)
    lb = LevenshteinSocNetRuby::LsnBuilder.new(10)
    lb.run
    LevenshteinSocNetRuby::LOG.warn lb.inspect
  end
end

if __FILE__ == $0
  LevenshteinSocNetRuby::LOG.warn "run w/ params: #{ARGV.inspect}"
  # sub_path = ARGV[0] || 'log'
  # max_words_sizes = ARGV[0] ? ARGV[0].split(",").collect{|p| p.to_i} : []
  max_words_sizes = ARGV[0].to_s.split(",").collect{|p| p.to_i}
  # bench = ARGV[2] && ARGV[2] == 'bench'
  LevenshteinSocNetRuby.main(max_words_sizes) # if __FILE__ == $0
else
  LevenshteinSocNetRuby::LOG.warn "required"
end

=begin

$ bundle exec bin/start.sh 10,20,40
pwd: /home/drhuffman/_dev_/levenshtein_soc_net_ruby
       user     system      total        real
max_words: 10   0.040000   0.000000   0.040000 (  0.037096)
max_words: 20   0.030000   0.000000   0.030000 (  0.034513)
max_words: 40   0.030000   0.000000   0.030000 (  0.035960)

# log/2016_12_06/app_00-00-42.log:

# Logfile created on 2016-12-06 00:00:42 -0500 by logger.rb/54362
W, [2016-12-06T00:00:42.537607 #18579]  WARN -- : run w/ params: ["10,20,40"]
W, [2016-12-06T00:00:42.537651 #18579]  WARN -- : Module -> max_words_sizes: '[10, 20, 40]'
W, [2016-12-06T00:00:42.574753 #18579]  WARN -- : #<LevenshteinSocNetRuby::LsnBuilder:0x000000019396e8 @input_file_path="the_challenge/input.txt", @max_lines=10, @raw_words_list=["horrid", "basement", "abbey", "recursiveness", "elastic", "macrographies", "a", "aardvark", "aardvark's"], @raw_test_words_list=["horrid", "basement", "abbey", "recursiveness", "elastic", "macrographies"], @clean_words_list=["a", "aardvark", "aardvarks", "abbey", "basement", "elastic", "horrid", "macrographies", "recursiveness"], @clean_word_lengths=[1, 5, 6, 7, 8, 9, 13], @raw_to_clean={"horrid"=>"horrid", "basement"=>"basement", "abbey"=>"abbey", "recursiveness"=>"recursiveness", "elastic"=>"elastic", "macrographies"=>"macrographies", "a"=>"a", "aardvark"=>"aardvark", "aardvark's"=>"aardvarks"}, @clean_to_raw={"horrid"=>["horrid"], "basement"=>["basement"], "abbey"=>["abbey"], "recursiveness"=>["recursiveness"], "elastic"=>["elastic"], "macrographies"=>["macrographies"], "a"=>["a"], "aardvark"=>["aardvark"], "aardvarks"=>["aardvark's"]}, @clean_to_length={}, @length_to_clean={}, @hist_to_length={}, @length_to_hist={}, @clean_to_hist={}, @hist_to_clean={}, @clean_to_friends={}, @clean_to_soc_net_members={}>
W, [2016-12-06T00:00:42.609361 #18579]  WARN -- : #<LevenshteinSocNetRuby::LsnBuilder:0x00000001e6c0e8 @input_file_path="the_challenge/input.txt", @max_lines=10, @raw_words_list=["horrid", "basement", "abbey", "recursiveness", "elastic", "macrographies", "a", "aardvark", "aardvark's"], @raw_test_words_list=["horrid", "basement", "abbey", "recursiveness", "elastic", "macrographies"], @clean_words_list=["a", "aardvark", "aardvarks", "abbey", "basement", "elastic", "horrid", "macrographies", "recursiveness"], @clean_word_lengths=[1, 5, 6, 7, 8, 9, 13], @raw_to_clean={"horrid"=>"horrid", "basement"=>"basement", "abbey"=>"abbey", "recursiveness"=>"recursiveness", "elastic"=>"elastic", "macrographies"=>"macrographies", "a"=>"a", "aardvark"=>"aardvark", "aardvark's"=>"aardvarks"}, @clean_to_raw={"horrid"=>["horrid"], "basement"=>["basement"], "abbey"=>["abbey"], "recursiveness"=>["recursiveness"], "elastic"=>["elastic"], "macrographies"=>["macrographies"], "a"=>["a"], "aardvark"=>["aardvark"], "aardvarks"=>["aardvark's"]}, @clean_to_length={}, @length_to_clean={}, @hist_to_length={}, @length_to_hist={}, @clean_to_hist={}, @hist_to_clean={}, @clean_to_friends={}, @clean_to_soc_net_members={}>
W, [2016-12-06T00:00:42.645373 #18579]  WARN -- : #<LevenshteinSocNetRuby::LsnBuilder:0x00000001721310 @input_file_path="the_challenge/input.txt", @max_lines=10, @raw_words_list=["horrid", "basement", "abbey", "recursiveness", "elastic", "macrographies", "a", "aardvark", "aardvark's"], @raw_test_words_list=["horrid", "basement", "abbey", "recursiveness", "elastic", "macrographies"], @clean_words_list=["a", "aardvark", "aardvarks", "abbey", "basement", "elastic", "horrid", "macrographies", "recursiveness"], @clean_word_lengths=[1, 5, 6, 7, 8, 9, 13], @raw_to_clean={"horrid"=>"horrid", "basement"=>"basement", "abbey"=>"abbey", "recursiveness"=>"recursiveness", "elastic"=>"elastic", "macrographies"=>"macrographies", "a"=>"a", "aardvark"=>"aardvark", "aardvark's"=>"aardvarks"}, @clean_to_raw={"horrid"=>["horrid"], "basement"=>["basement"], "abbey"=>["abbey"], "recursiveness"=>["recursiveness"], "elastic"=>["elastic"], "macrographies"=>["macrographies"], "a"=>["a"], "aardvark"=>["aardvark"], "aardvarks"=>["aardvark's"]}, @clean_to_length={}, @length_to_clean={}, @hist_to_length={}, @length_to_hist={}, @clean_to_hist={}, @hist_to_clean={}, @clean_to_friends={}, @clean_to_soc_net_members={}>
W, [2016-12-06T00:00:42.645497 #18579]  WARN -- : [#<Benchmark::Tms:0x00000001e6c9d0 @label="max_words: 10 ", @real=0.037095992996910354, @cstime=0.0, @cutime=0.0, @stime=0.0, @utime=0.040000000000000036, @total=0.040000000000000036>, #<Benchmark::Tms:0x000000017227b0 @label="max_words: 20 ", @real=0.034512522997829365, @cstime=0.0, @cutime=0.0, @stime=0.0, @utime=0.02999999999999997, @total=0.02999999999999997>, #<Benchmark::Tms:0x0000000181e948 @label="max_words: 40 ", @real=0.035960159002570435, @cstime=0.0, @cutime=0.0, @stime=0.0, @utime=0.030000000000000027, @total=0.030000000000000027>]


=end
