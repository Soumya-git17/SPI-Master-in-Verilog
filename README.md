# SPI Master in Verilog HDL

A parameterizable SPI (Serial Peripheral Interface) Master implemented in Verilog HDL using a modular RTL architecture. The design was verified using a self-checking Verilog testbench with directed and randomized test cases.

## Features

- SPI Master (Mode 0)
- Parameterized clock divider
- 8-bit serial data transfer
- Modular RTL design
- FSM-based controller
- Shift register based transmit/receive
- Bit counter for transfer completion
- Self-checking testbench
- Random and directed verification


## RTL Modules

| Module | Description |
|---------|-------------|
| spi_master_top | Top-level integration |
| spi_controller | Controls SPI transaction |
| clk_div | Generates SPI clock |
| shift_reg | Serial TX/RX register |
| bit_counter | Counts transmitted bits |

## Verification

- Directed Tests
- Random Tests
- MOSI Verification
- MISO Verification
- Scoreboard
- PASS/FAIL Summary

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave

