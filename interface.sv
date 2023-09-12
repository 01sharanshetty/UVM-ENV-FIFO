interface f_interface(input clk, reset);
  bit [DATA_W-1:0]i_wrdata;
  bit i_wren;
  bit i_rden;
  bit o_full;
  bit o_empty;
  bit o_alm_full;
  bit o_alm_empty;
  bit [DATA_W-1:0]o_rddata;

    clocking f_cb_driver @(posedge clk);
    default input #1 output #1;
    output i_wren;
    output rd;
    output i_wrdata;

    clocking f_cb_input_monitor @(posedge clk);
    default input #1 output #1;
    input i_wren;
    input i_rden;
    input i_wrdata; 

    clocking f_cb_output_monitor @(posedge clk);
    default input #1 output #1;
    input o_full;
    input o_empty;
    input o_alm_full;
    input o_alm_empty;
    input o_rddata;

      modport driver_mp (input clk, rstn, clocking f_cb_driver);
        modport input_monitor_mp (input clk, rstn, clocking f_cb_input_monitor);
          modport output_monitor_mp (input clk, rstn, clocking f_cb_output_monitor);
            
  endclocking

    endinterface
