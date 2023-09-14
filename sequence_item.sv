  parameter DATA_W = 128;
  parameter DEPTH = 1024;
  parameter UPP_TH = 4;
  parameter LOW_TH = 2;


class f_sequence_item extends uvm_sequence_item;
  
  //---------------------------------------
  //Input and Output data
  //---------------------------------------
  rand bit [DATA_W-1:0]i_wrdata;
  rand bit i_rden ;
  rand bit i_wren;
  bit o_full;
  bit o_empty;
  bit o_alm_full;
  bit o_alm_empty;
  bit [DATA_W-1:0]o_rddata;
  
  //---------------------------------------
  //Utility and Field macros
  //---------------------------------------
  `uvm_object_utils_begin(sequence_item)
  `uvm_field_int(i_wrdata, UVM_ALL_ON)
  `uvm_field_int(i_rden, UVM_ALL_ON)
  `uvm_field_int(i_wren, UVM_ALL_ON)
  `uvm_field_int(o_full, UVM_ALL_ON)
  `uvm_field_int(o_empty, UVM_ALL_ON)
  `uvm_field_int(o_alm_full, UVM_ALL_ON)
  `uvm_field_int(o_alm_empty, UVM_ALL_ON)
  `uvm_field_int(o_rddata, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="sequence_item");
  super.new(name);
  endfunction

endclass
