# Problem 4: Master–Slave Handshake FSM

## Goal
Implement a 4-phase handshake protocol between two FSMs over a shared 8-bit bus.

**Handshake steps:**
1. Master drives data, asserts `req`.
2. Slave latches data, asserts `ack` (for 2 cycles).
3. Master drops `req` after seeing `ack`.
4. Slave drops `ack` once `req=0`.

After 4 bytes (A0..A3), Master asserts `done=1` for one cycle.

## Files
- `master_fsm.v` → Master FSM RTL
- `slave_fsm.v` → Slave FSM RTL
- `link_top.v` → Top-level connection
- `tb_link_top.v` → Testbench
- `diagrams/` → FSM diagrams (Mermaid)

## How to Run
```bash
iverilog -o sim.out master_fsm.v slave_fsm.v link_top.v tb_link_top.v
vvp sim.out
gtkwave dump.vcd
