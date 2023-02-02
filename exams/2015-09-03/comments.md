# Comments about the exam of 20150903

## Scanner

The scanner is relatively simple. Most of the attentions should be given to regular expressions regarding token1, token2 and token3.

### token1:
- it starts with the character % repeated an odd number of times, at least 5: "%%%%%"("%%")*. Another possible solution could be "%%%"("%%")+
- or it starts with 2 o 3 repetitions of the words "**" and ??? in any combination (???**, ??????, **??????, ******,…): in this case the operator {n,m} should be used to manage the repetition of ** or ??? for a number of times between 2 and 3: ("**" | "???"){2,3}
- The first part of the token is optionally followed by an odd number between −35 and 333: in this context the regular expression has to recognize all the numbers, but only those, in the range. Remember that numbers have to be odd. As a consequence the regular expression of the less significant digit has to recognize only 1, 3, 5, 7, 9 digits: "-"(3[135] | [12][13579] | [13579]) | [13579] | [1-9][13579] | [12][0-9][13579] | 3([0-2][13579]|3[13])

### token2:
it is composed of two dates separated by the character - or by the character +: {date}("-" | "+"){date}
A date has the format YYYY/MM/DD and it is in the range between 2015/12/12 and 2016/03/13, with the exclusion of the day 2016/01/05. Remember that the month of February has 29 days. Regular expression has to recognize only the date that matches the requirements regarding days ranges: 2015"/"12"/"(1[2-9] | 2[0-9] | 3[01]) | 2016"/"(01"/"(0[1-46-9] | [12][0-9] | 3[01]) | 02"/"(0[1-9] | [12][0-9]) | 03"/"(0[1-9] | 1[0-3]))

### token3:
it is the character $ followed by a binary number between 101 and 101000. As in the previous regular expression, you have to take into account numbers range, but in this case numbers are binaries: "$"(101 | 110 | 111 | 1(0|1){3} | 1(0|1){4} | 10(1000|0(0|1){3}))

## Parser

(comments inside the code)

## Grammar

Regarding the grammar, the most complex part is the header section. It requires exactly one token2 and one token3, while any number of token1 can be found in the header. Since any order is possible, token2 and token3 can appear in the order TOKEN2 TOKEN3 or TOKEN3 TOKEN2. For this reason two header rules are present (see the | operator). Before the two tokens, between them, and after them any number (even 0) of token1 may be present. For this reason, in any position of the header grammar, adjacent to the two tokens, there is a list that may be empty. Consequently, the grammar of the header is the following:
```
header ::= token1_l TOKEN2 S token1_l TOKEN3 S token1_l
         | token1_l TOKEN3 S token1_l TOKEN2 S token1_l
;
 
token1_l ::= token1_l TOKEN1 S | /* epsilon */;
```
Another interesting part of the grammar is that concerning the list of cars composed of at least 2 elements and in even number:

```
cars ::= car car | cars car car;
```
the first part of the rule recognizes the first two elements, while the second part recognizes other two elements for any further reduction.

## Semantic

Semantic
Semantic regarding the car section is very easy and it is aimed to fill the data structure containing statistics regarding cars speed.

For the PRINT_MIN_MAX function, the idea is to access the <car_name> through inherited attributes. For the first element of the list (section_names ::= QSTRING) <car_name> is in position top-3 of the stack, because the stack content is MINMAX RO QSTRING RC RO QSTRING and the first QSTRING is the <car_name>. The array RESULT[] is initialized with the speed of the first element of the list. RESULT[0] is the current minimum value, while RESULT[1] is the current maximum value.
For the other elements of the list (section_names ::= section_names CM QSTRING) <car_name> is in position top-5 of the stack, because the stack content is MINMAX RO QSTRING RC RO section_names CM QSTRING. In this case, the rule checks the current speed, and if it is lower then the current minimum it saves the speed in RESULT[0]. Conversely, if the speed is greater than the current maximum, the speed is saved in RESULT[1]. At the end, in rule (min_max ::= MINMAX RO QSTRING RC RO section_names RC S) section_names contains the minimum and the maximum values.

Finally, rules drive_stats ::= QSTRING UINT M | drive_stats CM QSTRING UINT M have to access the <car_name> in order to obtain the speed of a given <section_name>. Two markers (NT0 and NT1) have been added to move the <car_name> just before the non terminal part. Markers are needed, because in this grammar there are two nested lists, and the inner list (drive_stats ::= QSTRING UINT M | drive_stats CM QSTRING UINT M) makes use of inherited attributes. It requires that the semantic value to be accessed has always the same offset in the stack. For rule drive_stats ::= QSTRING UINT M the <car_name> is in position top-6 of the stack (i.e., stack state is NT01 PART UINT COL QSTRING UINT M). NT01 means that the stack can contain NT0 or NT1. For rule drive_stats ::= drive_stats CM QSTRING UINT M the <car_name> is in position top-8 of the stack (i.e., stack state is NT01 PART UINT COL drive_stats CM QSTRING UINT M). At this point, the computation of the times in rules (drive_stats ::= QSTRING UINT M | drive_stats CM QSTRING UINT M) and the computation of the winner in rules (performances ::= QSTRING ARROW parts S | performances QSTRING ARROW parts S) is relatively easy java code.

Note: to print the car name before the reduction of rule performances ::= QSTRING ARROW parts S, intermediate actions can be used:

performances ::= QSTRING:s {: System.out.println(s); :} ARROW parts:x S;
an alternative solution is:

performances ::= c_name:s ARROW parts:x S;
c_name ::= QSTRING:s {: System.out.println(s); RESULT=s; :}


## Solution

To compile:

jflex scanner.jflex
java java_cup.Main paser.cup
javac *.java
or just use the makefile by typing:

make
To run the program on the example:

java Main exam_20150903.txt
The output is:

MIN: 10 MAX: 50
"CAR_A"
PART1: 2.0 s
PART2: 19.0 s
PART3: 10.0 s
TOTAL: 31.0 s
"CAR_B"
PART1: 4.0 s
PART2: 14.2 s
PART3: 11.0 s
TOTAL: 29.2 s
WINNER: "CAR_B" 29.2 s
