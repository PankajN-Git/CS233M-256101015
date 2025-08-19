This repository contains the Verilog implementation of a **Master-Slave handshake protocol** for a 4-byte burst data transfer. The system is designed using a modular approach with two separate Finite State Machines (FSMs) communicating through a top-level module.


# Files

  * **`master_fsm.v`**: The Master FSM. It initiates a 4-byte burst transfer by asserting a `req` signal and sending data. It also monitors the `ack` signal from the slave.
  * **`slave_fsm.v`**: The Slave FSM. It receives the `req` signal, latches the incoming data, and responds with a 2-cycle `ack` signal.
  * **`link_top.v`**: The top-level module that instantiates both the master and slave FSMs and connects their ports.
  * **`tb_link_top.v`**: The self-checking testbench that provides clock and reset and monitors the handshake process.
  * **`link_top.vcd`**: The generated waveform dump file from the simulation.


# Handshake Protocol

The communication between the master and slave is based on a request-acknowledge (`req`/`ack`) handshake. The master asserts `req` to signal a data transfer, and the slave asserts `ack` in response.

1.  The Master starts in the `S_IDLE` state.
2.  It transitions to the `S_REQ` state, asserts `req`, and puts the first byte of data on the bus.
3.  The Slave sees `req`, latches the data, and asserts `ack` for two clock cycles.
4.  The Master sees the `ack`, increments its internal byte counter, and sends the next byte.
5.  This process repeats for a total of 4 bytes.
6.  After the last byte is successfully acknowledged, the Master asserts a `done` signal for one clock cycle and returns to the `S_IDLE` state.

# Compile, Run, and Visualize Steps

To run the simulation and view the results, follow these steps:

1.  **Compile** all the Verilog design files and the testbench together using Icarus Verilog.
    ```iverilog -o sim.out tb_link_top.v
    ```
2.  **Run** the simulation. This command executes the compiled code and generates the `link_top.vcd` waveform file.
    ```vvp sim.out
    ```
3.  **Visualize** the waveforms using GTKWave to observe the `req` and `ack` handshake and the `done` signal.
    ```gtkwave link_top.vcd
    ```
