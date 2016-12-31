# Levenshtein Social Network

* Calculate the 'social network' quantity for a group of words based on their Levenshtein Distance.
* See: [CHALLENGE_RULES.md](CHALLENGE_RULES.md).

## Rule Clarification

### The Contest rules/requrements, which I have copied into RULES.md, should have been written a bit clearer. These rule include:

*) The input file has a 'word list' (one word per line, not counting 'END OF INPUT')
*) The 'word list' will be used to find the word friends of all 'word list' words and social network coounts of the test case words.

*) The input file has a delimiter line with the text: 'END OF INPUT'.

*) The words **before** 'END OF INPUT' are defined to be the 'test case words', but are NOT clearly defined to be included or not in the 'word list'.
   The output of the program should be just these 'test case words' and their social network counts.

*) The words **after** 'END OF INPUT' are defined to NOT be the test case words, but are NOT clearly defined to be the only words in the 'word list'.
    #
*) The contest rules state that for the given input file:
     "For each test case print out how big the social network for the word is. In sample the social network for the word 'elastic' is 3 and for the word 'recursiveness' is 1."
   The given input file has test case words of:
     horrid
     basement
     abbey
     recursiveness
     elastic
     macrographies
   Based on that sentence and the example input/output, the rules also imply that "macrographies" should have a count of 1.
   However, the test words "recursiveness" and "macrographies" are **not** in the 'after END OF INPUT' words of the given input file;
     and the other test case words are **duplicated** in the 'after END OF INPUT' words.
     Q: Should "recursiveness" and "macrographies" actually have a social net count of 0; or are we assuming that we count the word itself (even if it is not in the 'after' words)?
     Q: Likewise, should "elastic" (and the other 'duplicated' words) get counted twice, since it is in the test case words and in 'after' words?
     Q: Or, do we assume that we are to consolidate the words into a unique list of words?

*) The rules state "Two words are friends if they have a Levenshtein distance of 1 (For details see Levenshtein distance). That is, you can add,
   remove, or substitute exactly one letter in word X to create word Y.".
     Q: So, do we ignore 'non-letters'; if so what are we considering 'non-letters'.
     Q: If we are ignoring 'non-letters', then that must mean that we are to assume that we are to consolidate the words into a unique list of words!

### I am clarifying/extending the rules and making some assumptions:

*) The words before **and** after 'END OF INPUT' are to be **included** in the 'word list'; however that 'word list' will be a unique list of 'clean' versions of these words.
*) A 'letter' is not restricted to ASCII, but is unicode-aware.
*) A 'letter' excludes 'non-letters' like punctuation, which are limited to " " and "'" in the given input file.
   (See "the_challenge/fyi/test.rb" which uses /([^\u0000-\u007F]|\w)/ as the regexp to match against to determine if a character is a letter.)
*) All lines from the input file (except 'END OF INPUT') will have a 'raw' version and a 'clean' version.
   - The 'raw' version will be 'as-is' and the associated line number will be noted.
   - The 'clean' version will have the 'non-letter' characters trimmed out and the associated 'raw' word will be noted.
   That gives us 19673 words based on the given input file that will be trimmed due to them containing 'non-letter' characters.
*) The words in the 'word list' will exclude themselves from the list of their friends, but will include themselves in their own social network.
   Thus all words will have a minimum of 0 friends count and minimum of 1 social network count.

## Main concept of this approach:

The only words that could possibly (but not neccesarily) be 'friends' are only the pairs of words that:
 * have length difference of 0 or +/-1
 * have different histograms (e.g.: "abc" == {'a': 1, 'b': 1, 'c': 1}, "abb" == {'a': 1, 'b': 2}).

We will use this to help narrow down the combinations of comparisons for sake of determinging 'friends' and thus 'social networks', 

### This approach utilizes:
 * all words of length difference of 0 or +/-1 and with the different histogram might be 'friends'
 * adjustable # of words to process
 * 'raw' words vs (filtered) 'words' (i.e.: non-letter characters are ignored, such as '-', so "a-b" would be treated as if it is "ab") 
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
