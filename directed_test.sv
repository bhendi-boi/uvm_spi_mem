class directed_test extends uvm_test;
  `uvm_component_utils(directed_test)

  env environment;
  directed_seq directed_sequence;
  reset_seq reset_sequence;

  function new(string name = "directed_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("Directed Test", "Build phase directed test", UVM_HIGH)
    environment = env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);

    super.run_phase(phase);
    phase.raise_objection(this);

    directed_sequence = directed_seq::type_id::create("directed");
    reset_sequence = reset_seq::type_id::create("reset");
    reset_sequence.start(environment.agent.sequencer);
    directed_sequence.start(environment.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass
