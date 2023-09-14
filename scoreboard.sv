class f_scoreboard extends uvm_scoreboard;
  uvm_analysis_imp#(f_sequence_item, f_scoreboard) item_got_export_in;
  uvm_analysis_imp#(f_sequence_item, f_scoreboard) item_got_export_out;
  `uvm_component_utils(f_scoreboard)

    function new(string name = "f_scoreboard", uvm_component parent);
    super.new(name, parent);
      item_got_export_in = new("item_got_export_in", this);
      item_got_export_out = new("item_got_export_out", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  int queue[$];
  int c;
  int r_o_alm_full;
  int r_o_full;
  int r_o_alm_empty;
  int r_o_empty;
  int temp;
    function void write(input f_sequence_item item_got);
      bit [127:0] examdata;
      
      if((item_got.i_wren == 1) && (item_got.i_rden == 0))begin
        queue.push_back(item_got.i_wrdata);
        c=c+1;
        if((c>=(DEPTH-UPP_TH)) && (c<DEPTH)) begin
          r_o_alm_full=1; end
        if(c==DEPTH) begin
          r_o_full=1; end
       
        `uvm_info("write Data", $sformatf("write enable: %0b read enable: %0b data_in: %0h full: %0b almost full:%0b",item_got.i_wren, item_got.i_rden,item_got.i_wrdata, item_got.o_full, item_got.o_alm_full), UVM_LOW);

        if(r_o_alm_full==item_got.o_alm_full)
          $display("Almost Full Test Passed");
        else
          $display("Almost Full Test Failed");
        if(r_o_full==item_got.o_full)
           $display("Full Test Passed");
        else 
          $display("Full Test Failed");
      end


      if((item_got.i_wren == 0) && (item_got.i_rden == 1))begin
         if(queue.size() >= 'd1)begin
        examdata = queue.pop_front();
        c=c-1;
           
           if((c<=(LOW_TH)) && (c>0)) begin
          r_o_alm_empty=1; end
           if(c==0) begin
          r_o_empty=1; end
       
           `uvm_info("Read Data", $sformatf("write enable: %0b read enable: %0b data_out: %0h empty: %0b almost empty:%0b",item_got.i_wren, item_got.i_rden,item_got.o_rddata, item_got.o_empty, item_got.o_alm_empty), UVM_LOW);

           if(r_o_alm_empty==item_got.o_alm_empty)
             $display("Almost Empty Test Passed");
           else 
             $display("Almost Empty Test Failed");
           if(r_o_empty==item_got.o_empty)
             $display("Empty Test Passed");
           else
             $display("Empty Test Failed");
           if(examdata == item_got.o_rddata)
             $display("Input Data Matches With Output Data");
             else
               $display("Input Data Does Not Match With Output Data"); end

          
      end

      if((item_got.i_wren == 1) && (item_got.i_rden == 1)) begin
        temp=c;
        queue.push_back(item_got.i_wrdata);
        c=c+1;
        
        if(queue.size() >= 'd1)begin
           examdata = queue.pop_front();
          c=c-1; end
        if(c==temp)
          $display("Simulataneous write and read test pass");
        else 
          $display("Simulataneous write and read test fail");

      end


    endfunction

endclass
