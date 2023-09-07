class sequence_item extends uvm_sequence_item;
  
  //---------------------------------------
  //Input and Output data
  //---------------------------------------
  rand bit [7:0]data_in;
  rand bit rd;
  rand bit wr;
  bit full;
  bit empty;
  bit [7:0]data_out;
  
  //---------------------------------------
  //Utility and Field macros
  //---------------------------------------
  `uvm_object_utils_begin(fifo_seq_item)
  `uvm_field_int(data_in, UVM_ALL_ON)
  `uvm_field_int(rd, UVM_ALL_ON)
  `uvm_field_int(wr, UVM_ALL_ON)
  `uvm_field_int(full, UVM_ALL_ON)
  `uvm_field_int(empty, UVM_ALL_ON)
  `uvm_field_int(data_out, UVM_ALL_ON)
  `uvm_object_utils_end
