This repository contains the Verilog implementation of a **Mealy Vending Machine with Change**. The goal is to accept 5-cent and 10-cent coins to purchase an item that costs 20 cents. The machine provides a 5-cent change pulse if the payment is exactly 25 cents. The design uses a Mealy Finite State Machine (FSM) with a synchronous, active-high reset.


### Files

  * **`vending_mealy.v`**: The synthesizable Verilog module for the FSM.
  * **`tb_vending_mealy.v`**: The self-checking testbench used for simulation.
  * **`vending_mealy.vcd`**: The generated waveform dump file from the simulation.


### Functionality & Expected Behavior

The FSM has four states, representing the total amount of money collected: `S0` (0 cents), `S5` (5 cents), `S10` (10 cents), and `S15` (15 cents). The outputs, `dispense` and `chg5`, are generated based on both the current state and the incoming coin, which is the key characteristic of a Mealy machine.

The testbench verifies three main scenarios:

1.  **Exact Payment**: Inserting four 5-cent coins brings the total to 20 cents. The `dispense` output should pulse high for one cycle when the last coin is inserted.
2.  **Overpayment (25 cents)**: Inserting two 10-cent coins and a 5-cent coin brings the total to 25 cents. The `dispense` and `chg5` outputs should both pulse high for one cycle when the last coin is inserted.
3.  **Mixed Payment**: Inserting a combination of 5-cent and 10-cent coins to reach 25 cents. The `dispense` and `chg5` outputs should both pulse high for one cycle on the last coin.


### Compile, Run, and Visualize Steps

To run the simulation and view the results, follow these steps:

1.  **Compile** both Verilog files together using Icarus Verilog.
   
    iverilog -o sim.out tb_vending_mealy.v
   
2.  **Run** the executable to generate the waveform file.
    
    vvp sim.out
    
3.  **Visualize** the waveforms using GTKWave.
  
    gtkwave vending_mealy.vcd
   
