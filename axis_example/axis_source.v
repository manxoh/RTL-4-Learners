module axis_source #(AXIS_WIDTH = 32)
                                  (input clk,
                                   input reset,
                                   input en,
                                   input [AXIS_WIDTH-1:0] data_in,
                                   output m_axis_tvalid,
                                   output [AXIS_WIDTH-1:0] m_axis_tdata,
                                   input m_axis_tready);

   //internal signals
   wire [AXIS_WIDTH-1:0] data_next;
   reg [AXIS_WIDTH-1:0] data_i;
   reg valid_i;

   //modify data
   assign data_next = data_i + 1'b1; // assign data_next = en ? (data_i + 1'b1) : data_i;

   //outputs
   assign m_axis_tvalid = valid_i;
   assign m_axis_tdata = data_i;

   always @ (posedge clk) begin
      if (reset) begin
         valid_i <= 1'b0;
         data_i <= {AXIS_WIDTH{1'b0}};
      end
      else if ((valid_i == 1'b0) && (en == 1'b1)) begin  //start driving output data and valid
         valid_i <= 1'b1;
         data_i <= data_in;
      end
      else if ((valid_i == 1'b1) && (m_axis_tready == 1'b1) && (en == 1'b1)) begin //drive new output data when handshake is done
         data_i <= data_next;
      end
      else if ((valid_i == 1'b1) && (m_axis_tready == 1'b1) && (en == 1'b0)) begin //enable is deasserted, but wait for handshake to complete to deassert valid
         valid_i <= 1'b0;
      end
   end

endmodule
