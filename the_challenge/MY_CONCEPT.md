# Levenshtein Social Network

* Calculate the 'social network' quantity for a group of words based on their Levenshtein Distance.
* See: [CHALLENGE_RULES.md](CHALLENGE_RULES.md).

## Main concept of this approach:

The only words that could possibly be 'friends' are only the pairs of words that:
 * have length difference of 0 or +/-1
 * have different histograms (e.g.: "abc" == {'a': 1, 'b': 1, 'c': 1}, "abb" == {'a': 1, 'b': 2}).

### This approach utilizes:
 * all words of length difference of 0 or +/-1 and with the different histogram might be 'friends'
 * adjustable # of words to process
 * 'raw' words vs (filtered) 'words' (i.e.: some characters are ignored, such as '-', so "a-b" would be treated as if it is "ab") 
 * word lengths
   - words of length difference of more than one by definition are NOT 'friends'
 * the histogram of letters of each word
   - all words with the same histogram are by definition are NOT 'friends'
     - e.g.: 'abc' and 'cba' have the same histogram, but require more than one change
   - all words of different histogram and length difference of 0 or +/-1 might be 'friends'
     - e.g.: 'abc' and 'ab' have the different histograms, and require one change (remove)
     - e.g.: 'abc' and 'abb' have the different histograms, and require one change (replace)
     - e.g.: 'abc' and 'abcd' have the different histograms, and require one change (add)
 * histogram 'friends' (i.e.: exactly 1 letter is different, either via 'add a letter', 'remove a letter', or 'change a letter')
 * word 'friends' (i.e.: likewise, filtered by various combinations of that word's histogram and that histogram's 'friends')
 * social network (i.e.: a word's social network is all of the words that it can get to via it's friends' and their 'friends', etc.)

#### For example, given the following word list:

```
abc
abcd
abd
ab'd
abcde
xyz
x-y z
```

#### We'd end up with:

| word | qty in soc network | friends | soc network
|---|---|---|---
| abc | 3 | "abcd", "abd" (aka "ab'd") | "abcd", "abd", "abcde"
| abcd | 3 | "abc", "abd" (aka "ab'd") | "abc", "abd", "abcde"
| abd | 3 | "abc", "abcd" | "abc", "abcd", "abcde"
| ab'd | 3 | "abc", "abcd" | "abc", "abcd", "abcde"
| abcde | 3 | "abcd" | "abc", "abcd", "abd"
| xyz | 0 | (none) | (none) |
| x-y z | 0 | (none) | (none) |

See also the `report.*.txt` files (under [the_challenge/expected_output](the_challenge/expected_output)) for more sample runs (of various `max_lines`) against [the_challenge/input.txt](the_challenge/input.txt), such as:

* `report.21.txt`:
```
    horrid,1
    basement,1
    abbey,1
    recursiveness,1
    elastic,1
    macrographies,1
```

* `report.42.txt`:
```
    horrid,1
    basement,5
    abbey,1
    recursiveness,1
    elastic,1
    macrographies,1
```

* `report.42.txt`:
```
    horrid,1
    basement,5
    abbey,2
    recursiveness,1
    elastic,1
    macrographies,1
```
