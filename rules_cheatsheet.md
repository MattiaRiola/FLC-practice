# Rules cheatsheet

## List of elements

meanings:

- `LE = list of element`
- `EL = empty list`
- `E = element`

### Left-recursive elements


`LE ::= E | LE C E ;`

### Right-recursive elements
:warning: try to avoid Right recursive, **always prefer left recursive**
`LE ::= E | E C LE ;`

### List that can be empty

:warning: **the empty symbol 'ɛ' can be obtained using the rule in cup like this:** `EMPTYLIST ::= LE | ;` *(the last '| ' before the ';' is considered an empty symbol)*

- Solution 1:
*Empty list can be composed by symbol empty, or list of element*
`EL ::= ɛ | LE ;`
`LE ::= E | LE E ;`

- Solution 2:
`EL ::= ɛ | EL E;`

- :warning: WORNG SOLUTION:
**THIS IS WORNG**
`EL ::= ɛ | E | EL E;`

### List of elements (exact # of eleemnt)

- example 1: 3 or more elements
`LE ::= E E E | LE E;`

- example 2: List of an odd # of elements
`LE ::= E E E | LE E E ;`

- example 3: List of an odd # of elements that can be empty
add this rule to example 2:
`EL ::= ɛ | LE `