`timescale 1ns / 1ns


// UVM imports
import uvm_pkg::*;
`include "uvm_macros.svh"

// file imports
`include "interface.sv"
`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "coverage.sv"
`include "env.sv"
`include "directed_test.sv"

module tb;

  logic clk;
  initial begin
    clk = 1;
    forever #5 clk = ~clk;
  end

  // interface
  intf vif (.clk(clk));

  // dut
  top dut (
      .clk (vif.clk),
      .rst (vif.rst),
      .addr(vif.addr),
      .din (vif.din),
      .wr  (vif.wr),
      .dout(vif.dout),
      .done(vif.done),
      .err (vif.err)
  );


  initial begin
    uvm_config_db#(virtual intf)::set(null, "*", "vif", vif);
    run_test("directed_test");
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end

endmodule
