`include "input_agent.sv"
`include "output_agent.sv"
`include "scoreboard.sv"

class f_environment extends uvm_env;
  f_input_agent f_in_agt;
  f_output_agent f_out_agt;
  f_scoreboard f_scb;
  `uvm_component_utils(f_environment)
  
  function new(string name = "f_environment", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    f_in_agt = f_input_agent::type_id::create("f_in_agt", this);
    f_out_agt = f_output_agent::type_id::create("f_out_agt", this);
    f_scb = f_scoreboard::type_id::create("f_scb", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    f_in_agt.f_in_mon.item_got_port.connect(f_scb.item_got_export_in);
    f_out_agt.f_out_mon.item_got_port.connect(f_scb.item_got_export_out);
  endfunction
  
endclass
