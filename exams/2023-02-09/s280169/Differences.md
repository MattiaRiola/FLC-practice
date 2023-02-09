# Modifications

## Scanner

- Added a regex for real positive number with multiple decimal (used for weight of ingredients)

## Parser

### Header grammar

- added some cases without conflicts about the order of the tokens
  - (my solution produced an ambiguous grammar so I wanted to change it in an non-ambiguous grammar but I ran out of time)

### Food list

- Added output for less and most expensive ingredients based on euro/kg
  - I wrote 2 different solution for this: 
    - Using global variable (parser.cup)
    - Search the max and the min prices in the symbol_table (can be computational heavy but I don't use other global variables other than symbol_table) (code in parserComputeMinMax.cup)

### Recipe list

At labinf I wrote the grammar of the recipe section and the code related to get the information about weight of the ingredient used and the price/kg (from the symbol_table).

Changes:
- Semplify grammar of RECIPE (delete of INGREDIENT non terminal to semplify the values used to produce the output)
- Added a marker for quantity of the RECIPE and take it from the parser stack
- Added output for recipes prices
