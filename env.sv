class env extends uvm_env;
  `uvm_component_utils(env)

  agnt agent;
  scb  scoreboard;
  cvg coverage;

  function new(string name = "env", uvm_component parent);

    super.new(name, parent);
    `uvm_info("Env", "Constructed environment", UVM_HIGH)
  endfunction

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);
    `uvm_info("Env", "Build phase environment", UVM_HIGH)
    agent = agnt::type_id::create("agent", this);
    scoreboard = scb::type_id::create("scoreboard", this);
    coverage = cvg::type_id::create("coverage",this);
  endfunction

  function void connect_phase(uvm_phase phase);

    super.connect_phase(phase);
    `uvm_info("Env", "Connect phase environment", UVM_HIGH)
    agent.monitor.monitor_port.connect(scoreboard.scoreboard_port);
    agent.monitor.monitor_port.connect(coverage.coverage_port);
  endfunction


endclass
