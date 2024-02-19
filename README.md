# VerilogLogicGateMuxer
A Verilog module that dynamically performs XOR, NOR, and NAND operations on two 8-bit inputs, controlled by a pair of selection inputs. 

## Inputs & Outputs

- `s1`, `s0`: Selector inputs.
  - `s1=0`, `s0=0`: Output is `a XOR b`.
  - `s1=0`, `s0=1`: Output is `a NOR b`.
  - `s1=1`, `s0=0`: Output is `a NAND b`.
- `in0`, `in1`: 8-bit input vectors.
- **Output**: 8-bit result, varies based on `s1` and `s0`.
