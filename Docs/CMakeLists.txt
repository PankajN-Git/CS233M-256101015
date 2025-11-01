cmake_minimum_required(VERSION 3.10)
project(RVX10pSim NONE)

# Custom target to compile and run the Icarus Verilog simulation and open GTKWave
# Usage (from repo root):
#   cmake -S Docs -B build
#   cmake --build build --target run-sim
#
# The commands below assume the following relative paths in the repository:
#  - tb/tb_pipeline.sv
#  - src/datapath.sv
#  - src/controller.sv
#  - src/forwarding_unit.sv
#  - src/hazard_unit.sv
#  - src/memory.sv
#  - src/riscvpipeline.sv
#
# If your sources are in different locations, update the file list below.

add_custom_target(run-sim
  COMMAND iverilog -g2012 -o pipeline_sim tb/tb_pipeline.sv src/datapath.sv src/controller.sv src/forwarding_unit.sv src/hazard_unit.sv src/memory.sv src/riscvpipeline.sv
  COMMAND vvp pipeline_sim
  COMMAND gtkwave pipeline.vcd
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/..
  COMMENT "Compile with iverilog, run with vvp, then open GTKWave with pipeline.vcd"
  VERBATIM
)