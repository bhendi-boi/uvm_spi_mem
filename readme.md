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

### Commands

#### Tool setup

csh
source /home/installs/cshrc
source /home/ec5018_lab10/coverage.cshrc
setenv UVM_HOME /home/uvm-1.2
setenv UVM_HOME_LIB $XCELIUMHOME/tools.lnx86/methodology/UVM/CDNS-1.2/sv/lib/64bit

#### Run Directed Test

xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' '-access' '+rw' '+UVM_VERBOSITY=UVM_MEDIUM' '+UVM_TESTNAME=error_test' '-svseed' '2' -uvmnocdnsextra -uvmhome $UVM_HOME $UVM_HOME/src/uvm_macros.svh design.sv testbench.sv -coverage all -covoverwrite -covtest test_directed

##### Generate report for directed test

imc -batch -init imc.tcl

#### Run Error Test

xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' '-access' '+rw' '+UVM_VERBOSITY=UVM_MEDIUM' '+UVM_TESTNAME=error_test' '-svseed' '2' -uvmnocdnsextra -uvmhome $UVM_HOME $UVM_HOME/src/uvm_macros.svh design.sv testbench.sv -coverage all -covoverwrite -covtest test_error

##### Merge reports

imc -batch -init merge.tcl

#### Run Base Directed test

xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' '-access' '+rw' '+UVM_VERBOSITY=UVM_MEDIUM' '+UVM_TESTNAME=base_directed_test' '-svseed' '2' -uvmnocdnsextra -uvmhome $UVM_HOME $UVM_HOME/src/uvm_macros.svh design.sv testbench.sv -coverage all -covoverwrite -covtest test_base_directed

##### Generate final merged report

imc -gui -init merge_final.tcl
