module axis_source #(AXIS_WIDTH = 32)
                                  (input clk,
                                   input reset,
                                   input en,
                                   input [AXIS_WIDTH-1:0] init_data,
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
      end
      else begin 
         if (en) begin  //start driving valid high
            valid_i <= 1'b1;
         end
         else begin
            if (valid_i && m_axis_tready) begin //handshake done
               valid_i <= 1'b0;
            end
         end
      end
   end

   always @ (posedge clk) begin
      if (reset) begin
         data_i <= {AXIS_WIDTH{1'b0}};
      end
      else begin
         if (en) begin
            if (valid_i && m_axis_tready) begin //handshake done, data can be changed
               data_i <= data_next;
            end
            else begin
               if (~valid_i) begin
                  data_i <= init_data + 1'b1;
               end
            end
         end
      end
   end

endmodule
