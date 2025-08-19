This repository contains the Verilog implementation and a testbench for a **Mealy Overlapping Sequence Detector**. The module's goal is to detect the serial bit pattern **`1101`** from a single-bit input stream, asserting a 1-cycle output pulse (`y`) on the clock cycle when the last bit of the pattern is received. The detector handles overlapping sequences, meaning the last bit of a detected pattern can also be the start of a new one.

# Files

 "seq_detect_mealy.v": The core Verilog module containing the FSM logic.
  "tb_seq_detect_mealy.v": The self-checking testbench used for simulation and verification.
  "seq_detect_mealy.vcd": The generated waveform dump file from the simulation.


# Compile, Run, and Visualize Steps

To run the simulation and view the results, follow these steps in your terminal:

1.  **Compile** the Verilog files using Icarus Verilog. The `-o` flag specifies the output executable file name.
    iverilog -o  seq_detect_mealy.v tb_seq_detect_mealy.v seq_detect_mealy.vvp
    
3.  **Run** the simulation. This command executes the compiled code and generates the `sim.out` waveform file.
    vvp sim.out
  
4.  **Visualize** the waveforms using GTKWave.
    ```bash
    gtkwave seq_detect_mealy.vcd



# Expected Behavior

The testbench drives a series of bitstreams into the `detector_1101` module to verify its functionality. The expected behavior is as follows:

1.  **Simple Sequence (`1101`)**: A single pulse is expected at the end of the sequence.
2.  **Overlapping Sequences (`1101101`)**: The detector should identify two overlapping patterns. The first pulse will occur for the first `1101`, and the second pulse will occur for the second, as the last `1` of the first pattern also serves as the beginning of the next.
3.  **Sequences with Leading Ones and Zeros (`11011011101`)**: The detector should correctly detect the pattern.

When viewing the waveform, you should see a `1`-cycle pulse on the `y` output signal for each of these detections.
