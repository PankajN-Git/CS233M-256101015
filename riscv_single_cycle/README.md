**This document details the modifications RISC-V to implement the RVX-10 custom instruction set extension.**

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 1. **Documentation**

- Added a clear instruction encoding table for both base and RVX-10 instructions.


## 2. **ALU Control Path Enhancements**

- **Widened `ALUControl` signal from 3 bits to 5 bits** throughout the datapath (controller, decoder, datapath, ALU) for increased operation coverage.
- Established unique codes for each RVX-10 instruction to ensure clarity in decoding and execution.


## 3. **Instruction Decoding and Control Logic**

- **Controller:**
    - Modified to accept a 3-bit field `{Instr[30], Instr[26:25]}` for custom instruction decoding, supplementing RISC-V's standard funct7/funct3 fields.
    - Improved decoding logic for new RVX-10 instructions.
- **maindec:**
    - Added case for `7'b0001011` (RVX-10 opcode).
    - Assigned a unique `ALUOp` pattern (`2'b11`) for all custom operations.


## 4. **ALU Decoder (`aludec`) Refactor**

- Introduced a consolidated 5-bit RVX-10 instruction selector `RVX10ins`.
- Mapped all new instructions (ANDN, ORN, XNOR, MIN, MAX, MINU, MAXU, ROL, ROR, ABS) to their respective `ALUControl` codes.
- Ensured backward compatibility for standard RISC-V operations (add, sub, and, or, slt, etc.).


## 5. **ALU Module Extension**

- Implemented all RVX-10 operations.
    - **Bitwise logic:** ANDN, ORN, XNOR.
    - **Comparisons:** MIN, MAX, MINU, MAXU.
    - **Rotations:** ROL, ROR.
    - **Absolute value:** ABS.
- Used well-documented combinational logic for each operation.
- Maintained canonical RISC-V ALU behaviors for legacy instructions.


## 6. **Immediate Extension Improvements**

- Enhanced clarity in immediate construction for all instruction types (I/S/B/J) with explicit bit field documentation.
- Provided professional comments on bit replication and field mapping.


## 7. **General Code Quality Upgrades**

- Added comprehensive comments explaining changes and logic throughout all modified modules.
- Ensured signal naming consistency, explicit bit widths, and type safety.
- Introduced waveform dumping (`$dumpfile`/`$dumpvars`) in the testbench for professional simulation analysis.


## 8. **Instruction and ALUControl Mapping Table**

| Instruction | Opcode   | Funct3 | Funct7   | ALUControl | Description     |
|-------------|----------|--------|----------|------------|----------------|
| add         | 0110011  | 000    | 0000000  | 00000      | Addition       |
| sub         | 0110011  | 000    | 0100000  | 00001      | Subtraction    |
| and         | 0110011  | 111    | 0000000  | 00010      | Bitwise AND    |
| or          | 0110011  | 110    | 0000000  | 00011      | Bitwise OR     |
| xor         | 0110011  | 100    | 0000000  | 00100      | Bitwise XOR    |
| slt         | 0110011  | 010    | 0000000  | 00101      | Set Less Than  |
| ...         | ...      | ...    | ...      | ...        | ...            |
| andn        | 0001011  | 000    | 0000000  | 10000      | AND with NOT   |
| orn         | 0001011  | 001    | 0000000  | 10001      | OR with NOT    |
| xnor        | 0001011  | 010    | 0000000  | 10010      | XNOR           |
| min         | 0001011  | 000    | 0000001  | 10011      | Minimum (signed) |
| max         | 0001011  | 001    | 0000001  | 10100      | Maximum (signed) |
| minu        | 0001011  | 010    | 0000001  | 10101      | Minimum (unsigned)|
| maxu        | 0001011  | 011    | 0000001  | 10110      | Maximum (unsigned)|
| rol         | 0001011  | 000    | 0000010  | 11000      | Rotate Left    |
| ror         | 0001011  | 001    | 0000010  | 11001      | Rotate Right   |
| abs         | 0001011  | 000    | 0000011  | 10111      | Absolute Value |


## 9. **Simulation and Validation**

- The testbench remains unchanged except for enhanced waveform support.
- To compile and run:
    ```bash
    iverilog -g2012 -o processor.out riscvsingle_new.sv
    vvp processor.out
    ```
- On success, the simulation prints `Simulation succeeded` when 25 is written to memory address 100.


## 10. **Summary**

These changes transform the original RISC-V single-cycle processor into a professionally structured design supporting all required RVX-10 custom instructions, with clear, maintainable, and extensible code.
