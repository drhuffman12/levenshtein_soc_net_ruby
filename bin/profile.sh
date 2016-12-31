#!/usr/bin/env bash
# prep log_path:
now=$(date +"%Y_%m_%d")
#year=$(date +"%Y")
#month=$(date +"%m")
#day=$(date +"%d")
#log_path=log/callgrind/$year/$month/$day
log_path=log/$now
mkdir -p $log_path

# gather profile data:
#RLIMIT_DATA=1000 valgrind --tool=callgrind ruby lib/levenshtein_soc_net_ruby.rb
#valgrind --tool=callgrind ruby lib/levenshtein_soc_net_ruby.rb $*

bin/profile.rb $log_path "$*"
# TODO (?): Find out how to use valgrind w/ a Ruby app. The following don't work:
#valgrind --tool=callgrind bundle exec ruby ./lib/levenshtein_soc_net_ruby.rb $*
#valgrind --tool=callgrind ruby ./lib/levenshtein_soc_net_ruby.rb $*
#valgrind --tool=callgrind ./lib/levenshtein_soc_net_ruby.rb $*

 # > log/levenshtein_soc_net_ruby.log
#--track-origins=yes

# move profile data under log_path:
echo "Wait for callgrind file to be filled; sleeping .."
sleep 5
echo "profile.sh -> pwd: $(pwd)"
files=$(ls ./callgrind.out.* 2> /dev/null | wc -l)
until [ **"$files" != "0"** ]
do
  echo "Callgrind file not found; sleeping .."
  sleep 5
done
echo "Callgrind file found; moving.."
mv callgrind.out.* $log_path
exit
