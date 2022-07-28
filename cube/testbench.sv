// Code your testbench here
// or browse Examples
module testbench;

  logic clock, reset;
  logic [31:0] num;
  logic [31:0] result;
  
  cube cube_tb (.clock(clock),
                .reset(reset),
                .num(num),
                .result(result)
               );
  
    initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(-1, testbench);
      clock <= 1'b0;
      reset <= 1'b0;
      #10 reset <= 1'b1;
      #20 reset <= 1'b0;
  
      #05 num <= 32'h2;
            
      #10 num <= 32'h3;
      
      #10 num <= 32'h4;
      
      #10 num <= 32'h5;
    end
  
   always begin
     #5 clock <= !clock;
   end
  
endmodule