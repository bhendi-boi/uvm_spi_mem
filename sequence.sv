class base_seq extends uvm_sequence;
  `uvm_object_utils(base_seq)

  transaction tr;

  function new(string name = "base_sequence");
    super.new(name);
    `uvm_info("Base sequence", "Constructed base sequence", UVM_HIGH)
  endfunction

  task body();
    tr = transaction::type_id::create("tr");
    start_item(tr);
    tr.randomize() with {
      rst == 0;
    };
    finish_item(tr);
  endtask

endclass

class reset_seq extends uvm_sequence;
  `uvm_object_utils(reset_seq)

  transaction tr;

  function new(string name = "reset_sequence");
    super.new(name);
    `uvm_info("Reset sequence", "Constructed reset sequence", UVM_HIGH)
  endfunction

  task body();
    tr = transaction::type_id::create("tr");
    start_item(tr);
    tr.randomize() with {
      rst == 1;
    };
    finish_item(tr);
  endtask

endclass

class directed_seq extends uvm_sequence;
  `uvm_object_utils(directed_seq)

  transaction tr;
  int i;

  function new(string name = "directed_sequence");
    super.new(name);
    `uvm_info("Directed sequence", "Constructed directed sequence", UVM_HIGH)
  endfunction

  task body();
    tr = transaction::type_id::create("tr");
    i  = 0;
    for (i = 0; i < 32; i++) begin
      // write transaction 
      start_item(tr);
      tr.randomize() with {
        rst == 0;
        addr == i;
        wr == 1;
      };
      finish_item(tr);
      // read transaction 
      start_item(tr);
      tr.randomize() with {
        rst == 0;
        addr == i;
        wr == 0;
      };
      finish_item(tr);
    end
  endtask

endclass

class error_seq extends uvm_sequence;
  `uvm_object_utils(error_seq)

  transaction tr;
  int i;
  function new(string name = "error_sequence");
    super.new(name);
    `uvm_info("Error sequence", "Constructed error sequence", UVM_HIGH)
  endfunction

  task body();
    tr = transaction::type_id::create("tr");
    i  = 0;
    for (i = 0; i < 10; i++) begin
      // write transaction 
      start_item(tr);
      tr.randomize() with {
        rst == 0;
        addr > 32;
        wr == 1;
      };
      finish_item(tr);
      // read transaction 
      start_item(tr);
      tr.randomize() with {
        rst == 0;
        addr > 32;
        wr == 0;
      };
      finish_item(tr);
    end
  endtask
endclass