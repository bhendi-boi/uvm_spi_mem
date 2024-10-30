class drv extends uvm_driver #(transaction);
  `uvm_component_utils(drv)

  virtual intf vif;
  transaction  tr;

  function new(string name = "driver", uvm_component parent);

    super.new(name, parent);
    `uvm_info("Driver", "Constructed driver", UVM_HIGH)
  endfunction

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);
    `uvm_info("Driver", "Build phase driver", UVM_HIGH)

    if (!(uvm_config_db#(virtual intf)::get(this, "*", "vif", vif))) begin
      `uvm_fatal("Driver", "Driver couldn't get vif")
    end
  endfunction

  task run_phase(uvm_phase phase);

    super.run_phase(phase);
    `uvm_info("Driver", "Run phase driver", UVM_HIGH)
    tr = transaction::type_id::create("tr");

    forever begin
      seq_item_port.get_next_item(tr);
      driver(tr);
      `uvm_info("Driver", "Drove a transaction", UVM_NONE)
      seq_item_port.item_done();
    end
  endtask

  task driver(transaction tr);
    @(posedge vif.clk);
    vif.rst  <= tr.rst;
    vif.addr <= tr.addr;
    vif.din  <= tr.din;
    vif.wr   <= tr.wr;
    if(!tr.rst)
    @(posedge vif.done);
  endtask
endclass
