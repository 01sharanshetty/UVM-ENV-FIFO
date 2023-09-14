import uvm_pkg::*;
`include "uvm_macros.svh"
`include "interface.sv"
`include "test.sv"

module tb;
    // Parameters for FIFO configuration
  localparam DATA_W = 128;
  localparam DEPTH = 1024;
  localparam UPP_TH = 4;
  localparam LOW_TH = 2;
  
  bit clk;
  bit rstn;
  
  always #5 clk = ~clk;
  
  initial begin
    clk = 1;
    rstn = 0;
    #5;
    rstn = 1;
  end

  f_interface tif(clk, reset);

    SYN_FIFO #(
    .DATA_W(DATA_W),
    .DEPTH(DEPTH),
    .UPP_TH(UPP_TH),
    .LOW_TH(LOW_TH)
    ) dut(.clk(tif.clk),
                 .rstn(tif.rstn),
               .i_wrdata(tif.i_wrdata),
                 .i_wren(tif.i_wren),
                 .i_rden(tif.i_rden),
                 .o_full(tif.o_full),
                 .o_empty(tif.o_empty),
                 .o_alm_full(tif.o_alm_full),
                 .o_alm_empty(tif.o_alm_empty),
                 .o_rddata(tif.o_rddata));

  initial begin
    uvm_config_db#(virtual f_interface)::set(null, "", "vif", tif);
    $dumpfile("dump.vcd"); 
    $dumpvars;
    run_test("f_test");
  end
  
endmodule
