

//TEST_1: Generate 1024 continuous writes with no read operation

 
class f_sequence_test1 extends uvm_sequence #(f_sequence_item);

 `uvm_object_utils(f_sequence_test1)

 f_sequence_item fsi;
 
 function new(string name = "f_sequence_test1");
    super.new(name);
endfunction


 task body();
  `uvm_info(get_type_name(), $sformatf("******** Generate 1024 continuous writes with no read operation ********"), UVM_LOW)
  repeat(1024) begin
   fsi= f_sequence_item::type_id::create("fsi_write");
   start_item(fsi);
   assert(fsi.randomize() with {fsi.i_wren == 1; fsi.i_rden == 0;});
   finish_item(fsi);
   end

endtask
endclass

//TEST_2: Generate 1024 continuous read with no write operation

class f_sequence_test2 extends uvm_sequence #(f_sequence_item);

 `uvm_object_utils(f_sequence_test2)

 f_sequence_item fsi;
 
 function new(string name = "f_sequence_test2");
    super.new(name);
endfunction


 task body();
  `uvm_info(get_type_name(), $sformatf("******** Generate 1024 continuous read with no write operation ********"), UVM_LOW)
  repeat(1024) begin
   fsi= f_sequence_item::type_id::create("fsi_read");
   start_item(fsi);
   assert(fsi.randomize() with {fsi.i_wren == 0; fsi.i_rden == 1;});
   finish_item(fsi);
   end

endtask
endclass



 
  
