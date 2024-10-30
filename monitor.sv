class mon extends uvm_monitor;
  `uvm_component_utils(mon)

  virtual intf vif;
  transaction tr;

  uvm_analysis_port #(transaction) monitor_port;

  function new(string name = "mon", uvm_component parent);

    super.new(name, parent);
    `uvm_info("Monitor", "Constructed monitor", UVM_HIGH)
  endfunction

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);
    `uvm_info("Monitor", "Build phase monitor", UVM_HIGH)
    monitor_port = new("monitor_port", this);

    if (!(uvm_config_db#(virtual intf)::get(this, "*", "vif", vif)))
      `uvm_fatal("Monitor", "Couldn't get vif in monitor!")
  endfunction

  task run_phase(uvm_phase phase);

    super.run_phase(phase);
    `uvm_info("Monitor", "Build phase monitor", UVM_HIGH)
    tr = transaction::type_id::create("item");
    // needed to sinc monitor with driver.
    @(posedge vif.clk);
    wait (!vif.rst);
    forever begin
      main();
      `uvm_info("Monitor", "Sampled a sequence", UVM_NONE)
      monitor_port.write(tr);
    end
  endtask

  task main();
    @(posedge vif.clk);
    tr.rst  = vif.rst;
    tr.din  = vif.din;
    tr.addr = vif.addr;
    tr.wr   = vif.wr;

    @(posedge vif.done);
    tr.done = vif.done;
    tr.dout = vif.dout;
    tr.err  = vif.err;
    /* @(posedge vif.clk); */
  endtask


endclass
