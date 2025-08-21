# Problem 2: Two-Road Traffic Light (Moore FSM)

**Goal:** Control NS/EW traffic lights with shared 1 Hz tick.  
**Timing:** NS Green (5s) → NS Yellow (2s) → EW Green (5s) → EW Yellow (2s) → repeat.  
**Reset:** synchronous, active-high.

## Files
- `traffic_light.v` → FSM RTL
- `tb_traffic_light.v` → Testbench (tick generated every 20 cycles for simulation speed)
- `diagrams/state_diagram.md` → State diagram (Mermaid)

## How to Run
```bash
iverilog -o sim.out traffic_light.v tb_traffic_light.v
vvp sim.out
gtkwave dump.vcd
