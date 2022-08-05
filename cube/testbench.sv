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
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(0, testbench);
    end
  
  	initial begin
      reset = 1'b0;
      num = 32'b0;
      reset_done = 1'b0;
    end
  
  	initial begin
      #4 reset = 1'b1;
      #12 reset = 1'b0;
      reset_done = 1'b1;
    end
  
  	initial begin
      //wait until reset is done
      @ (posedge reset_done);
      forever begin
        @ (posedge clock) begin
          num = num + 1'b1;
          result_expected.push_back(power(num, 3));
        end
      end
    end
      
	initial begin
      //wait until reset is done
      @ (posedge reset_done);
      $display("[%03f] Reset done", $realtime);

      //Pipeline takes 3 clock cycles to compute result, extra clock for registering input and output 
      @ (posedge clock);
      @ (posedge clock);
      @ (posedge clock);
      @ (posedge clock);        

      forever begin
        @ (posedge clock) begin
          front = result_expected.pop_front();
          status =  (result != front) ? "FAIL":"PASS";
          $display("[%03f] %s expected %d actual %d", $realtime, status, front, result);
        end
      end
    end
  
   initial begin
     clock = 1'b0;
     forever #5 clock = !clock;
   end
  
endmodule