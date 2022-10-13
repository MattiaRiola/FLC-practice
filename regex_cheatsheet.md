- [Regex cheatsheet](#regex-cheatsheet)
  - [Characters](#characters)
  - [Quantifiers](#quantifiers)
  - [More characters](#more-characters)
  - [Logic](#logic)
  - [More White-Space](#more-white-space)
  - [More Quantifiers](#more-quantifiers)
  - [Character Classes](#character-classes)
  - [Anchors and Boundaries](#anchors-and-boundaries)

# Regex cheatsheet

## Characters

| Character | Legend                                                                                   | Example      | Sample Match |
| --------- | ---------------------------------------------------------------------------------------- | ------------ | ------------ |
| \d        | Most engines: one digit from 0 to 9                                                      | `file_\d\d ` | `file_25 `   |
| \d        | .NET, Python 3: one Unicode digit in any script                                          | `file_\d\d ` | `file_9੩ `   |
| \w        | Most engines: "word character": ASCII letter, digit or underscore                        | `\w-\w\w\w ` | `A-b_1`      |
| \w        | .Python 3: "word character": Unicode letter, ideogram, digit, or underscore              | `\w-\w\w\w ` | `字-ま_۳ `   |
| \w        | .NET: "word character": Unicode letter, ideogram, digit, or connector                    | `\w-\w\w\w ` | `字-ま‿۳ `   |
| \s        | Most engines: "whitespace character": space, tab, newline, carriage return, vertical tab | `a\sb\sc   ` | `a b c   `   |
| \s        | .NET, Python 3, JavaScript: "whitespace character": any Unicode separator                | `a\sb\sc   ` | `a b c   `   |
| \D        | One character that is not a digit as defined by your engine's \d                         | `\D\D\D    ` | `ABC     `   |
| \W        | One character that is not a word character as defined by your engine's \w                | `\W\W\W\W\W` | `*-+=)   `   |

## Quantifiers

| Quantifier | Legend              | Example          | Sample Match     |
| ---------- | ------------------- | ---------------- | ---------------- |
| '+         | One or more         | `Version \w-\w+` | `Version A-b1_1` |
| {3}        | Exactly three times | `\D{3}`          | `ABC`            |
| {2,4}      | Two to four times   | `\d{2,4}`        | `156`            |
| {3,}       | Three or more times | `\w{3,}`         | `regex_tutorial` |
| *          | Zero or more times  | `A*B*C*`         | `AAACC`          |
| ?          | Once or none        | `plurals?`       | `plural`         |

## More characters

| Character | Legend                                                   | Example                             | Sample Match      |
| --------- | -------------------------------------------------------- | ----------------------------------- | ----------------- |
| .         | Any character except line break                          | `a.c`                               | `abc`             |
| .         | Any character except line break                          | `.*`                                | ` whatever, man.` |
| \ .       | A period (special character: needs to be escaped by a \) | `a\.c`                              | ` a.c`            |
| \         | Escapes a special character                              | `\.\*\+\?    \$\^\/\\|.*+?    $^/\` | `.*+?    $^/\`    |
| \         | Escapes a special character                              | `\[\{\(\)\}\]`                      | [{()}]            |


## Logic

| Logic   | Legend                   | Example               | Sample Match            |
| ------- | ------------------------ | --------------------- | ----------------------- |
| &#124;  | Alternation / OR operand | 22&#124;33            | 33                      |
| ( … )   | Capturing group          | A(nt&#124;pple)       | Apple (captures "pple") |
| \1      | Contents of Group 1      | r(\w)g\1x             | regex                   |
| \2      | Contents of Group 2      | (\d\d)\+(\d\d)=\2\+\1 | 12+65=65+12             |
| (?: … ) | Non-capturing group      | A(?:nt&#124;pple)     | Apple                   |
| Apple   |

## More White-Space

| Logic   | Legend                    | Example               | Sample Match            | FIELD5 | FIELD6  | FIELD7       |
| ------- | ------------------------- | --------------------- | ----------------------- | ------ | ------- | ------------ |
| &#124;  | Alternation / OR operand  | 22&#124;33            | 33                      |        |         |              |
| ( … )   | Capturing group           | A(nt&#124;pple)       | Apple (captures "pple") |        |         |              |
| \1      | Contents of Group 1       | r(\w)g\1x             | regex                   |        |         |              |
| \2      | Contents of Group 2       | (\d\d)\+(\d\d)=\2\+\1 | 12+65=65+12             |        |         |              |
| (?: … ) | Non-capturing group       | A(?:nt&#124;pple)     | AppleCharacter          | Legend | Example | Sample Match |
| \t      | Tab                       | T\t\w{2}              | T     ab                |        |         |              |
| \r      | Carriage return character | see below             |                         |        |         |              |
| \n      | Line feed character       | see below             |                         |        |         |              |
| \r\n    | Line separator on Windows | AB\r\nCD              | AB CD                   |        |         |              |

## More Quantifiers

| Quantifier | Legend                           | Example  | Sample Match |
| ---------- | -------------------------------- | -------- | ------------ |
| '+         | The + (one or more) is "greedy"  | \d+      | 12345        |
| ?          | Makes quantifiers "lazy"         | \d+?     | 1 in 1 2345  |
| *          | The * (zero or more) is "greedy" | A*       | AAA          |
| ?          | Makes quantifiers "lazy"         | A*?      | empty in AAA |
| {2,4}      | Two to four times, "greedy"      | \w{2,4}  | abcd         |
| ?          | Makes quantifiers "lazy"         | \w{2,4}? | ab in ab cd  |

## Character Classes

| Character | Legend                                                                      | Example        | Sample Match                                                               |
| --------- | --------------------------------------------------------------------------- | -------------- | -------------------------------------------------------------------------- |
| [ … ]     | One of the characters in the brackets                                       | [AEIOU]        | One uppercase vowel                                                        |
| [ … ]     | One of the characters in the brackets                                       | T[ao]p         | Tap or Top                                                                 |
| -         | Range indicator                                                             | [a-z]          | One lowercase letter                                                       |
| [x-y]     | One of the characters in the range from x to y                              | [A-Z]+         | GREAT                                                                      |
| [ … ]     | One of the characters in the brackets                                       | [AB1-5w-z]     | One of either: A,B,1,2,3,4,5,w,x,y,z                                       |
| [x-y]     | One of the characters in the range from x to y                              | [ -~]+         | Characters in the printable section of the ASCII table .                   |
| [^x]      | One character that is not x                                                 | [^a-z]{3}      | A1!                                                                        |
| [^x-y]    | One of the characters not in the range from x to y                          | [^ -~]+        | Characters that are not in the printable section of the ASCII table .      |
| [\d\D]    | One character that is a digit or a non-digit                                | [\d\D]+        | Any characters, inc- luding new lines, which the regular dot doesn't match |
| [\x41]    | Matches the character at hexadecimal position 41 in the ASCII table, i.e. A | [\x41-\x45]{3} | ABE                                                                        |


## Anchors and Boundaries

| Anchor | Legend                                                                                                          | Example         | Sample Match               |
| ------ | --------------------------------------------------------------------------------------------------------------- | --------------- | -------------------------- |
| ^      | Start of string or start of line depending on multiline mode. (But when [^inside brackets], it means "not")     | ^abc .*         | abc (line start)           |
| $      | End of string or end of line depending on multiline mode. Many engine-dependent subtleties.                     | .*? the end$    | this is the end            |
| \A     | Beginning of string (all major engines except JS)                                                               | \Aabc[\d\D]*    | abc (string... ...start)   |
| \z     | Very end of the string Not available in Python and JS                                                           | the end\z       | this is...\n... the end    |
| \Z     | End of string or (except Python) before final line break Not available in JS                                    | the end\Z       | this is...\n... the end \n |
| \G     | Beginning of String or End of Previous Match .NET, Java, PCRE (C, PHP, R…), Perl, Ruby                          |                 |                            |
| \b     | Word boundary Most engines: position where one side only is an ASCII letter, digit or underscore                | Bob.*\bcat\b    | Bob ate the cat            |
| \b     | Word boundary .NET, Java, Python 3, Ruby: position where one side only is a Unicode letter, digit or underscore | Bob.*\b\кошка\b | Bob ate the кошка          |
| \B     | Not a word boundary                                                                                             | c.*\Bcat\B.*    | copycats                   |

