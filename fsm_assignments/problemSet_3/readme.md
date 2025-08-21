# Problem 3: Vending Machine FSM (Mealy)

**Goal:** Vending machine with price = 20. Accepts 5, 10 coins.  
- `dispense=1` when total >= 20.  
- If total = 25, also `chg5=1`.  
- Total resets after vend.  

## Files
- `vending_mealy.v` → FSM RTL
- `tb_vending_mealy.v` → Testbench
- `diagrams/state_diagram.md` → State diagram

## How to Run
```bash
iverilog -o sim.out vending_mealy.v tb_vending_mealy.v
vvp sim.out
gtkwave dump.vcd
