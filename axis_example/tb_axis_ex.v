module tb_axis_ex;

localparam AXIS_WIDTH = 32;

reg clk;
reg reset;
reg en;
reg [AXIS_WIDTH-1:0] data = {AXIS_WIDTH{1'b0}};
wire m_axis_tvalid;
wire [AXIS_WIDTH-1:0] m_axis_tdata;
reg m_axis_tready;

axis_source #(AXIS_WIDTH) dut (.clk(clk),
                                               .reset(reset),
                                                .en(en),
                                                .data(data),
                                                .m_axis_tvalid(m_axis_tvalid),
                                                .m_axis_tdata(m_axis_tdata),
                                                .m_axis_tready(m_axis_tready)
                                          );


initial begin
   clk <= 1'b0;
   forever #5 clk <= ~clk;
end

initial begin
   reset = 1'b0;
   en = 1'b0;
   #5 reset = 1'b1;
   #10 reset = 1'b0;
   # 10 en = 1'b1;
      data = 1'b1;
   # 250 en = 1'b0;
   #20 $finish;
end

initial begin
   m_axis_tready <= 1'b0;
   forever begin
      @ (posedge clk);
       m_axis_tready <= ~m_axis_tready;
   end
end

endmodule
