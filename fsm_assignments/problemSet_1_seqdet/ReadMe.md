# Problem 1 — Mealy Sequence Detector (Pattern = 1101, Overlap)

**Goal:** Detect serial bit pattern `1101` on `din` with overlap. Output `y` is a 1-cycle pulse when the last `1` arrives.  
**Reset:** synchronous, active-high.  
**Type:** Mealy.

## Files
- `seq_detect_mealy.v` — synthesizable RTL
- `tb_seq_detect_mealy.v` — self-checking-ish testbench (prints cycles)
- `diagrams/state_diagram.md` — Mermaid state diagram (renders on GitHub)

## How to run (Icarus Verilog + GTKWave)
```bash
iverilog -o sim.out seq_detect_mealy.v tb_seq_detect_mealy.v
vvp sim.out
gtkwave dump.vcd
