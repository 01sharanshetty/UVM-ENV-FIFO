class f_output_monitor extends uvm_monitor;

  virtual f_interface vif;
  f_sequence_item fsi;
  uvm_analysis_port#(f_sequence_item) item_got_port;

  `uvm_component_utils(f_output_monitor)

  function new(string name = "f_output_monitor", uvm_component parent);
    super.new(name, parent);
    item_got_port = new("item_got_port2", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    fsi = f_sequence_item::type_id::create("fsi_monitor2");
    if(!uvm_config_db#(virtual f_interface)::get(this, "", "vif", vif))
      `uvm_fatal("Monitor: ", "No vif is found!")
  endfunction

      virtual task run_phase(uvm_phase phase);
      forever begin
      @(posedge vif.output_monitor_mp.clk)

        if((vif.input_monitor_mp.f_cb_input_monitor.i_wren == 1) && (vif.input_monitor_mp.f_cb_input_monitor.i_rden == 0))begin
          $display("\n[Output Monitor] Write is high and Read is low");
        fsi.o_full = vif.output_monitor_mp.f_cb_output_monitor.o_full;
        fsi.o_empty = vif.output_monitor_mp.f_cb_output_monitor.o_empty;
        fsi.o_alm_full = vif.output_monitor_mp.f_cb_output_monitor.o_alm_full;
        fsi.o_alm_empty = vif.output_monitor_mp.f_cb_output_monitor.o_alm_empty;
        fsi.o_rddata = vif.output_monitor_mp.f_cb_output_monitor.o_rddata;
        item_got_port.write(fsi);
      end

        if((vif.input_monitor_mp.f_cb_input_monitor.i_wren == 0) && (vif.input_monitor_mp.f_cb_input_monitor.i_rden == 1))begin
          $display("\n[Output Monitor] Write is low and Read is high");
        fsi.o_full = vif.output_monitor_mp.f_cb_output_monitor.o_full;
        fsi.o_empty = vif.output_monitor_mp.f_cb_output_monitor.o_empty;
        fsi.o_alm_full = vif.output_monitor_mp.f_cb_output_monitor.o_alm_full;
        fsi.o_alm_empty = vif.output_monitor_mp.f_cb_output_monitor.o_alm_empty;
        fsi.o_rddata = vif.output_monitor_mp.f_cb_output_monitor.o_rddata;
        item_got_port.write(fsi);
      end

        if((vif.input_monitor_mp.f_cb_input_monitor.i_wren == 1) && (vif.input_monitor_mp.f_cb_input_monitor.i_rden == 1))begin
          $display("\n[Output Monitor] Write is high and Read is high");
        fsi.o_full = vif.output_monitor_mp.f_cb_output_monitor.o_full;
        fsi.o_empty = vif.output_monitor_mp.f_cb_output_monitor.o_empty;
        fsi.o_alm_full = vif.output_monitor_mp.f_cb_output_monitor.o_alm_full;
        fsi.o_alm_empty = vif.output_monitor_mp.f_cb_output_monitor.o_alm_empty;
        fsi.o_rddata = vif.output_monitor_mp.f_cb_output_monitor.o_rddata;
        item_got_port.write(fsi);
      end

        if((vif.input_monitor_mp.f_cb_input_monitor.i_wren == 0) && (vif.input_monitor_mp.f_cb_input_monitor.i_rden == 0))begin
          $display("\n[Output Monitor] Write is low and Read is low");
        fsi.o_full = vif.output_monitor_mp.f_cb_output_monitor.o_full;
        fsi.o_empty = vif.output_monitor_mp.f_cb_output_monitor.o_empty;
        fsi.o_alm_full = vif.output_monitor_mp.f_cb_output_monitor.o_alm_full;
        fsi.o_alm_empty = vif.output_monitor_mp.f_cb_output_monitor.o_alm_empty;
        fsi.o_rddata = vif.output_monitor_mp.f_cb_output_monitor.o_rddata;
        item_got_port.write(fsi);
      end
      end
    endtask

    endclass
      
