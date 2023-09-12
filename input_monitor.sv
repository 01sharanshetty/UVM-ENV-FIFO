class f_input_monitor extends uvm_monitor;

  virtual f_interface vif;
  f_sequence_item fsi;
  uvm_analysis_port#(f_sequence_item) item_got_port;

  `uvm_component_utils(f_input_monitor)
  
  function new(string name = "f_input_monitor", uvm_component parent);
    super.new(name, parent);
    item_got_port = new("item_got_port", this);
  endfunction

    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      fsi = f_sequence_item::type_id::create("fsi_monitor");
    if(!uvm_config_db#(virtual f_interface)::get(this, "", "vif", vif))
      `uvm_fatal("Monitor: ", "No vif is found!")
  endfunction

 virtual task run_phase(uvm_phase phase);
      forever begin
      @(posedge vif.input_monitor_mp.clk)
        
        if((vif.input_monitor_mp.f_cb_input_monitor.i_wren == 1) && (vif.input_monitor_mp.f_cb_input_monitor.i_rden == 0))begin
          $display("\n Write is high and Read is low");
        fsi.i_wrdata = vif.input_monitor_mp.f_cb_input_monitor.i_wrdata;
        fsi.i_wren = vif.input_monitor_mp.f_cb_input_monitor.i_wren;
        fsi.i_rden = vif.input_monitor_mp.f_cb_input_monitor.i_rden;
        item_got_port.write(fsi);
      end
        
        if((vif.input_monitor_mp.f_cb_input_monitor.i_wren == 0) && (vif.input_monitor_mp.f_cb_input_monitor.i_rden == 1))begin
        $display("\n Read is high and Write is low");
        fsi.i_wrdata = vif.input_monitor_mp.f_cb_input_monitor.i_wrdata;
        fsi.i_wren = vif.input_monitor_mp.f_cb_input_monitor.i_wren;
        fsi.i_rden = vif.input_monitor_mp.f_cb_input_monitor.i_rden;
        item_got_port.write(fsi);
      end
        if((vif.input_monitor_mp.f_cb_input_monitor.i_wren == 1) && (vif.input_monitor_mp.f_cb_input_monitor.i_rden == 1))begin
        $display("\n Read is high and Write is high");
        fsi.i_rden = vif.input_monitor_mp.f_cb_input_monitor.i_rden;
        fsi.i_wrdata = vif.input_monitor_mp.f_cb_input_monitor.i_wrdata;
        fsi.i_wren = vif.input_monitor_mp.f_cb_input_monitor.i_wren;
        item_got_port.write(fsi);
      end

        if((vif.input_monitor_mp.f_cb_input_monitor.i_wren == 0) && (vif.input_monitor_mp.f_cb_input_monitor.i_rden == 0))begin
          $display("\n Read is low and Write is low");
          
        fsi.i_rden = vif.input_monitor_mp.f_cb_input_monitor.i_rden;
        fsi.i_wrdata = vif.input_monitor_mp.f_cb_input_monitor.i_wrdata;
        fsi.i_wren = vif.input_monitor_mp.f_cb_input_monitor.i_wren;
        item_got_port.write(fsi);
      end
    end
  endtask

      
  
