
 
class f_sequence_test extends uvm_sequence #(f_sequence_item);

 `uvm_object_utils(f_sequence_test1)

 f_sequence_item fsi;
 
 function new(string name = "f_sequence_test1");
    super.new(name);
endfunction


 task body();
//TEST_1: Generate 1024 continuous writes with no read operation

  `uvm_info(get_type_name(), $sformatf("******** Generate 1024 continuous writes with no read operation ********"), UVM_LOW)
  repeat(1024) begin
   fsi= f_sequence_item::type_id::create("fsi_write");
   start_item(fsi);
   assert(fsi.randomize() with {fsi.i_wren == 1; fsi.i_rden == 0;});
   finish_item(fsi);
   end

//TEST_2: Generate 1024 continuous read with no write operation

`uvm_info(get_type_name(), $sformatf("******** Generate 1024 continuous read with no write operation ********"), UVM_LOW)
  repeat(1024) begin
   fsi= f_sequence_item::type_id::create("fsi_read");
   start_item(fsi);
   assert(fsi.randomize() with {fsi.i_wren == 0; fsi.i_rden == 1;});
   finish_item(fsi);
   end

//TEST_3: Simultaneous read and write operation

 `uvm_info(get_type_name(), $sformatf("******** Simultaneous read and write operation ********"), UVM_LOW)
  repeat(20) begin
   fsi= f_sequence_item::type_id::create("fsi_simul_rw");
   start_item(fsi);
   assert(fsi.randomize() with {fsi.i_wren == 1; fsi.i_rden == 1;});
   finish_item(fsi);
   end

//TEST_4: Alternate read and write operation

`uvm_info(get_type_name(), $sformatf("******** Alternate write and read operation ********"), UVM_LOW)
  repeat(512) begin
   fsi= f_sequence_item::type_id::create("fsi_alt_rw");
   start_item(fsi);
   assert(fsi.randomize() with {fsi.i_wren == 1; fsi.i_rden == 0;});
   finish_item(fsi);

   fsi= f_sequence_item::type_id::create("fsi_alt_rw");
   start_item(fsi);
   assert(fsi.randomize() with {fsi.i_wren == 0; fsi.i_rden == 1;});
   finish_item(fsi);
   
   end

//TEST_5: Random write and read operation

 `uvm_info(get_type_name(), $sformatf("******** Random write and read operation ********"), UVM_LOW)
  repeat(250) begin
   fsi= f_sequence_item::type_id::create("fsi_rand_rw");
   start_item(fsi);
   assert(fsi.randomize());
   finish_item(fsi);   
   end

//TEST_6: No write and read operation

`uvm_info(get_type_name(), $sformatf("******** No write and read operation ********"), UVM_LOW)
  repeat(250) begin
   fsi= f_sequence_item::type_id::create("fsi_no_rw");
   start_item(fsi);
   assert(fsi.randomize() with {i_wren==0; i_rden==0;});
   finish_item(fsi);   
   end


endtask
endclass


