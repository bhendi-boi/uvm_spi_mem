class base_directed_test extends uvm_test;
  `uvm_component_utils(base_directed_test)

  env environment;
  reset_seq reset_sequence;
  base_seq base_sequence;

  function new(string name = "base_directed_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("Base Directed Test", "Build phase base directed test", UVM_HIGH)
    environment = env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);

    super.run_phase(phase);
    phase.raise_objection(this);

    base_sequence  = base_seq::type_id::create("base");
    reset_sequence = reset_seq::type_id::create("reset");
    reset_sequence.start(environment.agent.sequencer);
    base_sequence.start(environment.agent.sequencer);
    #300;
    phase.drop_objection(this);
  endtask

endclass
