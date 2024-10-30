interface intf(input logic clk);

  logic wr, rst;
  logic [7:0] addr, din;
  logic [7:0] dout;
  logic done, err;

endinterface
