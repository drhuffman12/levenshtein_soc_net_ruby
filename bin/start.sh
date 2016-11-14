#!/usr/bin/env bash
echo "pwd: $(pwd)"
bundle exec ruby lib/levenshtein_soc_net_ruby.rb $* > log/levenshtein_soc_net_ruby.log
