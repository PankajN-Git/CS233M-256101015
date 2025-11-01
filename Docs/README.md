# Docs

This directory contains helper files for running the Icarus Verilog simulation and viewing the waveform.

Files:
- `CMakeLists.txt` — CMake helper target `run-sim` that runs:
  1)  iverilog -g2012 -o pipeline_sim tb/tb_pipeline.sv src/...
  2)  vvp pipeline_sim
  3)  gtkwave pipeline.vcd
- `wave.png` — copy of the simulation waveform screenshot (uploaded by user) so the waveform image lives with the Docs helpers.

How to run the simulation using CMake:
1. From the repository root:
   cmake -S Docs -B build
   cmake --build build --target run-sim

Notes:
- The CMake target assumes the testbench and sources are at the relative paths shown above. If your files are located elsewhere, edit `Docs/CMakeLists.txt`.
- The waveform image is named `wave.png` and is stored in this Docs directory.