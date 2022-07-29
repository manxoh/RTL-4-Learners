// Code your testbench here
// or browse Examples
module testbench;

  logic clock, reset;
  logic [31:0] num;
  logic [31:0] result;
  //Queue to hold expected result
  logic [31:0] result_expected[$]; 
  logic [31:0] front; 
  logic reset_done;
  string status;
  
  cube dut (.clock(clock),
                .reset(reset),
                .num(num),
                .result(result)
               );
  
    initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(0, testbench);
      clock = 1'b0;
      reset = 1'b0;
      num = 32'b0;
      reset_done = 1'b0;
      #10 reset = 1'b1;
      #20 reset = 1'b0;
      #5 reset_done = 1'b1;
    end
  
  function automatic logic [31:0] power(logic [31:0] base, integer exp);
      logic [31:0] res = 32'h1;
      begin
        while (exp--) begin
          res = res*base;
        end
        return res;
      end
    endfunction
  
  	initial begin
      fork
      begin
        forever begin
          @ (posedge clock) begin
            if (reset_done == 1'b1) begin
              num = num + 1'b1;
              result_expected.push_back(power(num, 3));
            end
          end
        end
      end
      
      begin
        //wait until reset is done
        while (!reset_done) begin
          @ (posedge clock);
        end
        $display("[%3f] Reset done", $realtime);
        
        //Pipeline takes 3 clock cyles to compute result 
        @ (posedge clock);
        @ (posedge clock);
        @ (posedge clock);
        
        forever begin
          @ (posedge clock) begin
            if (reset_done == 1'b1) begin
              front = result_expected.pop_front();
              status =  (result != front) ? "FAIL":"PASS";
              $display("[%3f] %s expected %d actual %d", $realtime, status, front, result);
            end
          end
        end
      end
        
      join_any
      disable fork;
	end
  
   always begin
     #5 clock <= !clock;
   end
  
endmodule