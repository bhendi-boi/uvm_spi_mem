class error_test extends uvm_test;
  `uvm_component_utils(error_test)

  env environment;
  reset_seq reset_sequence;
  error_seq error_sequence;

  function new(string name = "error_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("Error Test", "Build phase error test", UVM_HIGH)
    environment = env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);

    super.run_phase(phase);
    phase.raise_objection(this);

    error_sequence = error_seq::type_id::create("error");
    reset_sequence = reset_seq::type_id::create("reset");
    reset_sequence.start(environment.agent.sequencer);
    error_sequence.start(environment.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass
