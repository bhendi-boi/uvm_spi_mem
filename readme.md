# SPI Memory verification with UVM

Design files taken from Udemy course

## File Structure

- `rtl` folder has all modules in separate files
- `design.sv` contains all the modules in a single file

## Design Spec

- ### interface
  ```
  logic wr, clk, rst;
  logic [7:0] addr, din;
  logic [7:0] dout;
  logic done, err;
  ```
- ### spi_mem
  ```
   reg [7:0] mem[31:0] = '{default: 0};
  ```
  A memory block with 32 words with 8bit word length.
- Synchronous active high reset
- A typical transaction starts with driving addr, wr and additionally din if required.
- End of a transaction is marked by done signal(Done is asserted even when an err is raised).

## Testplan

- ### Directed Test
  - Start with writing and reading address by address.
- ### Error Test
  - To ensure that err signal is being raised properly, make a different test which checks for err.
