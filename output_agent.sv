`include "sequence_item.sv"
`include "sequence.sv"
`include "output_monitor.sv"

class f_output_agent extends uvm_agent;
  f_output_monitor f_out_mon;

  `uvm_component_utils(f_output_agent)
  
  function new(string name = "f_output_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    f_out_mon = f_output_monitor::type_id::create("f_out_mon", this);
  endfunction

  
endclass
