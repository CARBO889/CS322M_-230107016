🧠 RVX10-P: Five-Stage Pipelined RISC-V Processor

A high-performance pipelined core implementing the RISC-V RV32I instruction set with RVX10 custom extensions for enhanced arithmetic and bitwise capabilities.

⚙️ Architecture Summary
🧩 Pipeline Structure

Stages: IF → ID → EX → MEM → WB

Base ISA: RV32I (32-bit integer instructions)

Register File: 32 registers (x0–x31, where x0 is hardwired to zero)

Memory Design: Harvard architecture (separate instruction and data memory paths)

⚡ Hazard Management

✅ Forwarding from MEM/WB to EX stage

✅ One-cycle stall for load-use hazards

✅ Store forwarding to maintain consistency

✅ Predict-not-taken branch prediction (1-cycle penalty)

✅ Pipeline flush on taken branches/jumps

🧮 RVX10 Instruction Extensions

The design adds 10 custom instructions using the CUSTOM-0 opcode slot, boosting performance on specific operations.

Type	Instructions
Bitwise	andn, orn, xnor
Comparison	min, max, minu, maxu
Rotation	rol, ror
Arithmetic	abs
🚀 Performance Overview

Average CPI: 1.2 – 1.3

Pipeline Utilization: 77% – 83%

Target Clock Frequency: ~500 MHz (≈2 ns period)

Peak Performance: ~400 MIPS

🗂️ Project Directory
rvx10_P/
├── src/
│   ├── datapath.sv              # Core pipeline and datapath logic
│   ├── riscvpipeline.sv         # Top-level integration module
│   ├── controller.sv            # Control signal generation
│   ├── forwarding_unit.sv       # Handles forwarding paths
│   └── hazard_unit.sv           # Detects and stalls on load-use hazards
│
├── tb/
│   ├── tb_pipeline.sv           # Basic functionality testbench
│   └── tb_pipeline_hazard.sv    # Hazard testing environment
│
├── tests/
│   ├── rvx10_pipeline.hex       # Base test program
│   └── rvx10_hazard_test.hex    # Hazard validation test
│
├── docs/
│   └── REPORT.md                # Design report
│
└── README.md                    # This documentation

🔧 Setup and Tools
Requirements

Icarus Verilog (iverilog): for Verilog simulation

GTKWave: waveform visualization (optional)

Make: for build automation (optional)

Installation
Ubuntu / Debian
sudo apt update
sudo apt install iverilog gtkwave

macOS
brew install icarus-verilog gtkwave

▶️ Getting Started
1️⃣ Clone the Repository
git clone https://github.com/yourusername/rvx10_P.git
cd rvx10_P

2️⃣ Build the Project
iverilog -g2012 -o pipeline_tb src/*.sv tb/tb_pipeline.sv

3️⃣ Run Simulation
vvp pipeline_tb

📊 Sample Simulation Output
STORE @ 96 = 0x00000000 (t=55000)
WB stage: Writing 5 to x10  t=75000
WB stage: Writing 3 to x11  t=85000
RVX10 EX stage: ALU result = 4 -> x5  t=105000
FORWARDING: EX-to-EX detected for x5 at t=120000
STORE @ 100 = 0x00000019 (t=325000)
Simulation succeeded
CHECKSUM (x28) = 25 (0x00000019)

🔹 Performance Summary
========== PIPELINE PERFORMANCE ==========
Total Cycles:         30
Instructions Retired: 25
Stall Cycles:         0
Flush Cycles:         0
Average CPI:          1.20
Pipeline Efficiency:  83.3%
==========================================

🧪 Testing
Functional Verification

To verify the core pipeline and custom instructions:

iverilog -g2012 -o pipeline_tb src/*.sv tb/tb_pipeline.sv
vvp pipeline_tb


Program Used: tests/rvx10_pipeline.hex

Expected Behavior:

Load-use stalls: 4

Forwarding events: 18

Total stores: 8

Average CPI: 1.29

📈 Viewing Waveforms

To visualize execution in GTKWave:

iverilog -g2012 -o pipeline_tb src/*.sv tb/tb_pipeline.sv
vvp pipeline_tb -vcd
gtkwave dump.vcd