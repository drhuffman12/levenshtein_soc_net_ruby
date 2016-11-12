# Challenge: [Levenshtein Distance](https://www.codeeval.com/open_challenges/58/)

    
## Sponsoring Company:
Square

## Challenge Description:

Two words are friends if they have a Levenshtein distance of 1 (For details see [Levenshtein distance](http://en.wikipedia.org/wiki/Levenshtein_distance)). That is, you can add, remove, or substitute exactly one letter in word X to create word Y. A word’s social network consists of all of its friends, plus all of their friends, and all of their friends’ friends, and so on. Write a program to tell us how big the social network for the given word is, using our word list.

### Input sample:

The first argument will be a path to a filename, containing words, and the word list to search in. The first N lines of the file will contain test cases, they will be terminated by string 'END OF INPUT'. After that there will be a list of words one per line. E.g

### Output sample:

```
recursiveness
elastic
macrographies
END OF INPUT
aa
aahed
aahs
aalii
...
...
zymoses
zymosimeters
```

For each test case print out how big the social network for the word is. In sample the social network for the word 'elastic' is 3 and for the word 'recursiveness' is 1. E.g.

```
1
3
1
```

### Constraints:

* Number of test cases N in range(15, 30)
* The word list always will be the same and it's length will be around 10000 words

[Login to submit solution](https://www.codeeval.com/accounts/login/?next=/open_challenges/58/)

# See also:

http://www.meetup.com/CoderNight/events/233221873/

> "Two words are friends if they have a Levenshtein distance of 1 (For details see Levenshtein distance). That is, you can add, remove, or substitute exactly one letter in word X to create word Y. A word’s social network consists of all of its friends, plus all of their friends, and all of their friends’ friends, and so on. Write a program to tell us how big the social network for the given word is, using our word list."

> Here's a file to run against if you want to work on this offline instead of using their editor.

> [Sample input file](https://dl.dropboxusercontent.com/u/6768419/input)