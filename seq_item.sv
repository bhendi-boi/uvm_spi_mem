class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)

  // inputs
  rand logic wr, rst;
  rand logic [7:0] addr, din;
  // outputs
  logic [7:0] dout;
  logic done, err;

  function new(string name = "transaction");
    super.new(name);
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("Write/Read",wr,1,UVM_HEX);
    printer.print_field_int("Address",addr,8,UVM_HEX);
    printer.print_field_int("Data In",din,8,UVM_HEX);
    printer.print_field_int("Data Out",dout,8,UVM_HEX);
    printer.print_field_int("Error",err,1,UVM_HEX);
  endfunction

endclass
