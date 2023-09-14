  parameter DATA_W = 128;
  parameter DEPTH = 1024;
  parameter UPP_TH = 4;
  parameter LOW_TH = 2;

class f_driver extends uvm_driver#(f_sequence_item);

virtual f_interface vif;
f_sequence_item fsi;
`uvm_component_utils(f_driver)

  function new(string name = "f_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual f_interface)::get(this, "", "vif", vif))
      `uvm_fatal("Driver: ", "No vif is found!")
  endfunction

   virtual task run_phase(uvm_phase phase);
    if(vif.driver_mp.rstn) begin
    vif.driver_mp.f_cb_driver.i_wren <= 'b0;
    vif.driver_mp.f_cb_driver.i_rden <= 'b0;
    vif.driver_mp.f_cb_driver.i_wrdata <= 'b0;
    end

    forever begin
      seq_item_port.get_next_item(fsi);
      if((fsi.i_wren == 1) && (fsi.i_rden == 0))
        begin
          @(posedge vif.driver_mp.clk)
           vif.driver_mp.f_cb_driver.i_wren <= 'b1;
           vif.driver_mp.f_cb_driver.i_wrdata <= fsi.i_wrdata;
          vif.driver_mp.f_cb_driver.i_rden <= 'b0;
          @(posedge vif.d_mp.clk)
           vif.driver_mp.f_cb_driver.i_wren <= 'b0;
           vif.driver_mp.f_cb_driver.i_rden <= 'b0;
          
        end
      if((fsi.i_wren == 0) && (fsi.i_rden == 1))
        begin
         @(posedge vif.driver_mp.clk)
          vif.driver_mp.f_cb_driver.i_rden <= 'b1;
          vif.driver_mp.f_cb_driver.i_wren <= 'b0;
          @(posedge vif.driver_mp.clk)
          vif.driver_mp.f_cb_driver.i_rden <= 'b0;
          vif.driver_mp.f_cb_driver.i_wren <= 'b0;
        end
      if((fsi.i_wren == 1) && (fsi.i_rden == 1))
        begin
         @(posedge vif.driver_mp.clk)
          vif.driver_mp.f_cb_driver.i_wren <= 'b1;
          vif.driver_mp.f_cb_driver.i_wrdata <= fsi.i_wrdata;
          vif.driver_mp.f_cb_driver.i_rden <= 'b1;
          @(posedge vif.driver_mp.clk)
          vif.driver_mp.f_cb_driver.i_wren <= 'b0;
          vif.driver_mp.f_cb_driver.i_rden <= 'b0;
        end
      if((fsi.i_wren == 0) && (fsi.i_rden == 0))
        begin
         @(posedge vif.driver_mp.clk)
          vif.driver_mp.f_cb_driver.i_rden <= 'b0;
          vif.driver_mp.f_cb_driver.i_wren <= 'b0;
          @(posedge vif.driver_mp.clk)
          vif.driver_mp.f_cb_driver.i_rden <= 'b0;
          vif.driver_mp.f_cb_driver.i_wren <= 'b0;
        end
      seq_item_port.item_done();
    end
