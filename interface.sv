interface f_interface(input clk, reset);
  bit [DATA_W-1:0]i_wrdata;
  bit i_wren;
  bit i_rden;
  bit o_full;
  bit o_empty;
  bit o_alm_full;
  bit o_alm_empty;
  bit [DATA_W-1:0]o_rddata;

    clocking f_cb @(posedge clk);
    default input #1 output #1;
    output wr;
    output rd;
    output data_in;
    input full;
    input empty;
    input data_out;
  endclocking
