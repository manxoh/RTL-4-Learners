module tb_axis_ex;

localparam AXIS_WIDTH = 32;

reg clk;
reg reset;
reg en;
reg [AXIS_WIDTH-1:0] data = {AXIS_WIDTH{1'b0}};
wire m_axis_tvalid;
wire s_axis_tvalid;
wire [AXIS_WIDTH-1:0] m_axis_tdata;
wire [AXIS_WIDTH-1:0] s_axis_tdata;
wire s_axis_tready;

axis_source #(AXIS_WIDTH) axi_source_inst (.clk(clk),
                                               .reset(reset),
                                                .en(en),
                                                .init_data(data),
                                                .m_axis_tvalid(s_axis_tvalid),
                                                .m_axis_tdata(s_axis_tdata),
                                                .m_axis_tready(s_axis_tready)
                                                );

axis_pipe #(AXIS_WIDTH) axi_pipe_inst (.clk(clk),
                                                                .reset(reset),
                                                               .s_axis_tvalid(s_axis_tvalid),
                                                               .s_axis_tdata(s_axis_tdata),
                                                               .s_axis_tready(s_axis_tready),
                                                               .m_axis_tvalid(m_axis_tvalid),
                                                               .m_axis_tdata(m_axis_tdata),
                                                               .m_axis_tready(m_axis_tready)
                                                               );

axis_sink #(AXIS_WIDTH) axi_sink_inst (.clk(clk),
                                                                .reset(reset),
                                                               .s_axis_tvalid(m_axis_tvalid),
                                                               .s_axis_tdata(m_axis_tdata),
                                                               .s_axis_tready(m_axis_tready)
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
   # 60 en = 1'b1;
      data = 4'b1001;
   # 250 en = 1'b0;
   #60 $finish;
end

endmodule
