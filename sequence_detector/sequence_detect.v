module sequence_detect(sysClk, resetL, sigA, outAH);

input sysClk, resetL, sigA;
output outAH;

/* outAH registered output*/
reg outAH;
/* outAH combinational output */
wire outAHC;

/* binary state encoding */
parameter [2:0] init    = 3'b000;
parameter [2:0] sn0     = 3'b001;
parameter [2:0] sn00    = 3'b010;
parameter [2:0] sn001   = 3'b011;
parameter [2:0] sn0011  = 3'b100;
parameter [2:0] sn00110 = 3'b101;
parameter [2:0] sn001100 = 3'b110;

/* FSM state variable */
reg [2:0] FSMState;

assign outAHC = (FSMState == sn001100) ? 1'b1 : 1'b0;

/* next state decode */
always @(posedge sysClk or negedge resetL)
    begin
        if (resetL == 1'b0)
            begin
                FSMState <= init;
            end
        else
            case (FSMState)
                init: begin
                        if (sigA == 1'b0)
                            begin
                                FSMState <= sn0;
                            end
                        else
                            begin
                                FSMState <= init;
                            end
                       end
                 sn0: begin
                        if (sigA == 1'b0)
                            begin
                                FSMState <= sn00;
                            end
                        else
                            begin
                                FSMState <= init;
                            end
                       end
                 sn00: begin
                         if (sigA == 1'b1)
                            begin
                                FSMState <= sn001;
                            end
                         else
                            begin
                                FSMState <= sn00;
                            end
                       end
                 sn001: begin
                            if (sigA == 1'b1)
                                begin
                                    FSMState <= sn0011;
                                end
                            else
                                begin
                                    FSMState <= sn0;
                                end
                        end
                 sn0011: begin
                            if (sigA == 1'b0)
                                begin
                                    FSMState <= sn00110;
                                end
                             else
                                begin
                                    FSMState <= init;
                                end
                         end
                 sn00110: begin
                            if (sigA == 1'b0)
                                begin
                                    FSMState <= sn001100;
                                end
                            else
                                begin
                                    FSMState <= init;
                                end
                          end
                   sn001100: begin
                     if (sigA == 1'b0)
                         begin
                             FSMState <= sn00;
                         end
                     else
                         begin
                             FSMState <= sn001;
                         end
                      end
                  default : begin
                                if (sigA == 1'b0)
                                    begin
                                        FSMState <= sn0;
                                    end
                                else
                                    begin
                                        FSMState <= init ;
                                    end
                            end
            endcase
    end

/* output */
always @(posedge sysClk)
    begin
        if (outAHC == 1'b1)
            begin
                outAH <= 1'b1;
            end
        else
            begin
                outAH <= 1'b0;
            end   
    end

endmodule


