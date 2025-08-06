module axis_sink #(AXIS_WIDTH = 32)
                                  (input clk,
                                   input reset,
                                   input s_axis_tvalid,
                                   input [AXIS_WIDTH-1:0] s_axis_tdata,
                                   output s_axis_tready
                                   );

   //internal signals
   reg [AXIS_WIDTH-1:0] data_i;
   reg s_axis_tready_i;

   //outputs
   assign s_axis_tready = s_axis_tready_i;

   always @ (posedge clk) begin
      if (reset) begin
         s_axis_tready_i <= 1'b1;
      end
      else begin
         if (s_axis_tvalid && s_axis_tready_i) begin //handshake
            s_axis_tready_i <= 1'b0;
         end
         else begin
            if (~s_axis_tready_i) begin
               s_axis_tready_i <= 1'b1;
            end
         end
      end
   end

   always @ (posedge clk) begin
      if (reset) begin
         data_i <= {AXIS_WIDTH{1'b0}};
      end
      else begin
         if (s_axis_tvalid && s_axis_tready_i) begin //handshake
            data_i <= s_axis_tdata;
         end
      end
   end

endmodule
