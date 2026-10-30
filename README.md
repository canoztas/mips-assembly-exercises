# MIPS assembly exercises

Two programs for MARS 4.5.

| File | Purpose | Default output |
| --- | --- | --- |
| `question1.asm` | Count array elements that are even and strictly smaller than K. | `4` |
| `question2.asm` | Select an arithmetic expression using nested function calls and stack saves. | `37` |

## Running

Open either file in MARS, assemble it, and run it. Keep **delayed branching disabled** and extended instructions enabled.

Command-line examples (replace the JAR path with your installation):

```sh
java -jar /path/to/Mars4_5.jar nc sm question1.asm
java -jar /path/to/Mars4_5.jar nc sm question2.asm
```

## Inputs

Edit the values in `.data` to try other inputs. `question1.asm` processes ten array elements and combines the results of `isEven` and `isLessThan`.

In `question2.asm`, `a > b` calls `process_data`: even `a` selects `4*a - b`, and odd `a` selects `2*a + 3*b`. Otherwise the result is `4*(a+b)`. The result is printed and stored in `result`. Multiplication is implemented with shifts and additions.
