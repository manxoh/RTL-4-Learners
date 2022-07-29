// Code your design here
module cube (input clock,
             input reset,
             input logic [31:0] num,
             output logic [31:0] result);
  
  logic [31:0] num0;
  logic [31:0] num1;
  logic [31:0] num2;
  logic [31:0] num3;
  
  always_ff @(posedge clock) begin
    if (reset == 1'b1) begin
    	num0 <= 32'b0;
      num1 <= 32'b0;
      num2 <= 32'b0;
      num3 <= 32'b0;
    end
    else begin
      //stage 1
      num0 <= num;
      num1 <= num;
      
      //state 2
      num2 <= num1;
      num3 <= num1*num0;
      
      //stage 3
      result <= num3*num2;
    end
      
  end
  
endmodule