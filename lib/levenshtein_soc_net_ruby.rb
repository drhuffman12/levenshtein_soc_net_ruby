#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require "logger"

require "levenshtein_soc_net_ruby/version"
require "levenshtein_soc_net_ruby/runner"
require "levenshtein_soc_net_ruby/raw_word_list"
require "levenshtein_soc_net_ruby/bench"

module LevenshteinSocNetRuby
  INPUT_FILE_PATH = 'the_challenge/input.txt'.freeze
  LOG = ::Logger.new(File.open("log/#{Time.now.strftime("%Y_%m_%d")}/app_#{Time.now.strftime("%H-%M-%S")}.log", "a"))

  def self.main( max_words_sizes) # string, []
    LOG.warn "#{self.class.name} -> max_words_sizes: '#{max_words_sizes}'"
    max_words_sizes.size > 1 ? bench(max_words_sizes) : run(max_words_sizes.first)
  end

  def self.bench(max_words_sizes)
    b = LevenshteinSocNetRuby::Bench.new(max_words_sizes)
    LevenshteinSocNetRuby::LOG.warn b.inspect
    b.run_all
  end

  def self.run(max_words)
    r = LevenshteinSocNetRuby::Runner.new(max_words)
    LevenshteinSocNetRuby::LOG.warn r.inspect
    r.run
  end
end

if __FILE__ == $0
  # sub_path = ARGV[0] || 'log'
  # max_words_sizes = ARGV[0] ? ARGV[0].split(",").collect{|p| p.to_i} : []
  max_words_sizes = ARGV[0].to_s.split(",").collect{|p| p.to_i}
  # bench = ARGV[2] && ARGV[2] == 'bench'
  LevenshteinSocNetRuby.main(max_words_sizes) # if __FILE__ == $0
end