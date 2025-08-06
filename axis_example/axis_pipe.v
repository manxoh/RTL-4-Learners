module axis_pipe #(AXIS_WIDTH = 32)
                                  (input clk,
                                   input reset,
                                   input s_axis_tvalid,
                                   input [AXIS_WIDTH-1:0] s_axis_tdata,
                                   output s_axis_tready,
                                   output m_axis_tvalid,
                                   output [AXIS_WIDTH-1:0] m_axis_tdata,
                                   input m_axis_tready);

   //internal signals
   reg s_axis_tready_i;
   wire no_stall;
   reg s_axis_tvalid_1d;
   reg [AXIS_WIDTH-1:0] s_axis_tdata_1d;
   reg m_axis_tvalid_i;
   reg [AXIS_WIDTH-1:0] m_axis_tdata_i;
   wire [AXIS_WIDTH-1:0] data_mux;
   wire valid_mux;


   //switch between skid buffer and input
   assign valid_mux = s_axis_tready_i ? s_axis_tvalid : s_axis_tvalid_1d;
   assign data_mux =  s_axis_tready_i ? s_axis_tdata : s_axis_tdata_1d;

   assign no_stall = (~m_axis_tvalid_i | m_axis_tready);

   //outputs
   assign s_axis_tready = s_axis_tready_i;
   assign m_axis_tvalid = m_axis_tvalid_i;
   assign m_axis_tdata = m_axis_tdata_i;

   //slave
   always @ (posedge clk) begin
      if (reset) begin
         s_axis_tready_i <= 1'b1;
      end
      else begin 
         if (no_stall) begin
            s_axis_tready_i <= 1'b1;
         end
         else begin
            if (valid_mux) begin
               s_axis_tready_i <= 1'b0;
            end
         end
      end
   end

   //skid buffer
   always @ (posedge clk) begin
      if (reset) begin
         s_axis_tvalid_1d <= 1'b0;
         s_axis_tdata_1d <= {AXIS_WIDTH{1'b0}};   
      end
      else begin
         if (s_axis_tready_i) begin
            s_axis_tvalid_1d <= s_axis_tvalid;
            s_axis_tdata_1d <= s_axis_tdata;   
         end
      end
   end

   //master valid
   always @ (posedge clk) begin
      if (reset) begin
         m_axis_tvalid_i <= 1'b0;
      end
      else begin 
         if (valid_mux) begin
            m_axis_tvalid_i <= 1'b1;
         end
         else begin
            if (m_axis_tready) begin // handshake done
               m_axis_tvalid_i <= 1'b0;
            end
         end
      end
   end

   // master data
   always @ (posedge clk) begin
      if (reset) begin
         m_axis_tdata_i <= {AXIS_WIDTH{1'b0}};
      end
      else begin
         if (no_stall) begin             
            m_axis_tdata_i <= data_mux;
         end
      end
   end

endmodule
