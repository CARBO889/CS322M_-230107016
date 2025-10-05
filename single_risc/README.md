# RISC-V Single-Cycle Processor (RV32I) - Rapid Setup Guide

This repository provides a **single-cycle RISC-V (RV32I) central processing unit** implementation, accompanied by a compact verification program. The following instructions detail how to compile and execute the simulation using **Icarus Verilog**.

---

## Included Files

- `riscvsingle.sv` — The complete SystemVerilog source code, encompassing the CPU core and its associated `testbench` module. The `testbench` acts as the top-level entity, which then instantiates the CPU (`top` module).
- `riscvtest.txt` — This file serves as the **instruction memory image**, formatted with one 32-bit hexadecimal word per line. It is loaded directly by the `$readmemh` system task during simulation initialization.
- `riscvtest.s` — (Optional) The **assembly language source** corresponding to the `riscvtest.txt` instruction image, included for architectural reference and comprehension.

> ✅ The simulation is configured to report **“Simulation succeeded”** upon detecting a write operation of the value **25 (0x19)** to memory **address 100 (0x64)** by the CPU.

---

## Prerequisites

To utilize this project, you will need:

- **Icarus Verilog** (specifically, the `iverilog` compiler and `vvp` runtime):
  - On Ubuntu/Debian systems: `sudo apt-get install iverilog`
  - On macOS with Homebrew: `brew install icarus-verilog`
  - For Windows: Download and install from the official Icarus Verilog website or via MSYS2. Ensure both `iverilog` and `vvp` executables are accessible within your system's **PATH** environment variable.
- (Optional) **GTKWave** for waveform visualization: `sudo apt-get install gtkwave` (Linux) / `brew install gtkwave` (macOS)

---

## Project Structure

Organize the aforementioned files within a single directory, as illustrated below:

riscv_processor/
├── riscvsingle.sv
├── riscvtest.txt
└── riscvtest.s        (optional)

> **Critical Note:** The simulation relies on a **relative path** to locate `riscvtest.txt`. Therefore, it is imperative to execute the simulator **from within the directory** containing this file (or modify the file path specified in `riscvsingle.sv` accordingly).

---

## Compilation & Execution (Command Line)

### For Linux / macOS Environments

```bash
# Navigate to your project directory
cd /path/to/riscv_processor

# Compile the SystemVerilog source, enabling SystemVerilog-2012 features
iverilog -g2012 -o cpu_tb riscvsingle.sv

# Execute the compiled simulation
vvp cpu_tb

For Windows Environments (PowerShell or CMD)
DOS

rem Navigate to your project directory
cd C:\path\to\riscv_processor

rem Compile the SystemVerilog source, enabling SystemVerilog-2012 features
iverilog -g2012 -o cpu_tb riscvsingle.sv

rem Execute the compiled simulation
vvp cpu_tb

Expected Output in Console:

Simulation succeeded

Makefile Integration (Optional)
A convenient Makefile is included for streamlined operations:

Bash

make run        # Compiles the design and starts the simulation.
make waves      # Compiles, runs the simulation, and opens 'wave.vcd' in GTKWave.
make clean      # Removes all generated files (e.g., 'cpu_tb', 'wave.vcd').
Should you prefer not to use make, the iverilog and vvp commands detailed above can be executed directly.

Waveform Analysis (Optional, requires GTKWave)
The testbench is instrumented to generate a Value Change Dump (.vcd) file named wave.vcd upon simulation completion. To inspect the waveforms:

Bash

# After successfully running the simulation:
gtkwave wave.vcd
If wave.vcd is not generated, confirm that the following SystemVerilog block is present within the module testbench; definition in riscvsingle.sv:

Code snippet

initial begin
  $dumpfile("wave.vcd");
  $dumpvars(0, testbench);
end
After verification, recompile and re-run the simulation to ensure the VCD file is produced.

Educational Context
This implementation represents a single-cycle execution model of a RISC-V (RV32I) subset, specifically designed for pedagogical purposes in computer architecture studies.

The included instruction program (riscvtest.txt) comprehensively tests core functionalities such as Arithmetic Logic Unit (ALU) operations, memory load/store instructions, and conditional branches.

The primary success criterion for this simulation is the successful storage of the value 25 at memory address 100, a specific event that signals the proper functioning of the CPU through the testbench's verification logic.

Licensing & Acknowledgments
This educational setup is an adaptation intended for academic coursework. The foundational single-cycle RISC-V example design draws upon established instructional materials for the RV32I instruction set architecture.
