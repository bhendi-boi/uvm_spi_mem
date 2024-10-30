class scb extends uvm_scoreboard;
  `uvm_component_utils(scb)

  uvm_analysis_imp #(transaction, scb) scoreboard_port;
  transaction trs[$];
  transaction tr;
  bit [7:0] mem[31:0] = '{default: 0};

  function new(string name = "scb", uvm_component parent);

    super.new(name, parent);
    `uvm_info("Scoreboard", "Constructed scoreboard", UVM_HIGH)
  endfunction

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);
    `uvm_info("Scoreboard", "Build phase scoreboard", UVM_HIGH)
    scoreboard_port = new("scoreboard_port", this);
  endfunction

  task run_phase(uvm_phase phase);

    super.run_phase(phase);
    `uvm_info("Scoreboard", "Run phase scoreboard", UVM_HIGH)
    tr = transaction::type_id::create("item", this);
    forever begin
      wait (!(trs.size() == 0));
      tr = trs.pop_front();
      tr.print();
      compare(tr);
    end
  endtask

  function void write(transaction tr);
    trs.push_back(tr);
    `uvm_info("Scoreboard", "Write method Scoreboard",UVM_NONE)
  endfunction

  function void compare(transaction tr);
    if (tr.wr) begin
      mem[tr.addr] = tr.din;
    end else begin
      if (mem[tr.addr] == tr.dout) begin
        `uvm_info("Scoreboard", "Read Successful", UVM_NONE)
      end else `uvm_error("Scoreboard", "Read unsuccessful!")
    end
  endfunction

endclass

