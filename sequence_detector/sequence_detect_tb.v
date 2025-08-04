`timescale 1ns / 10ps

module sequence_detect_tb();

reg sysClk_tb;
reg resetL_tb;
reg sigA_tb;

wire outAH_tb;

//self checking test bench variable
reg outAH_expected;

//trigger events
event testOutA;

sequence_detect sequence_detect_uut(sysClk_tb,
                                    resetL_tb,
                                    sigA_tb,
                                    outAH_tb);

//Start a clock
initial
    begin
        sysClk_tb = 1'b1;
        forever #50 sysClk_tb = ~sysClk_tb;
    end
    
//sigA stimulus    
    initial
        begin
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick1
        sigA_tb = 1'b0;
        @(posedge sysClk_tb);  //Start of tick2
        sigA_tb = 1'b0;
        @(posedge sysClk_tb);  //Start of tick3
        sigA_tb = 1'b1;
        @(posedge sysClk_tb);  //Start of tick4
        sigA_tb = 1'b1;
        @(posedge sysClk_tb);  //Start of tick5
        sigA_tb = 1'b0;
        @(posedge sysClk_tb);  //Start of tick6
        sigA_tb = 1'b0;
        @(posedge sysClk_tb);  //Start of tick7
        sigA_tb = 1'b1;
        #5 outAH_expected = 1'b1;
        #5 ->testOutA;
        @(posedge sysClk_tb);  //Start of tick8
        sigA_tb = 1'b0;
        @(posedge sysClk_tb);  //Start of tick9
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick10
        sigA_tb = 1'b1;
        @(posedge sysClk_tb); //Start of tick11
        sigA_tb = 1'b1;
        @(posedge sysClk_tb); //Start of tick12
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick13
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick14
        sigA_tb = 1'b0;
        #5 outAH_expected = 1'b1;
        #5 ->testOutA;
        @(posedge sysClk_tb); //Start of tick15
        sigA_tb = 1'b1;
        #5 outAH_expected = 1'b0;
        #5 ->testOutA;
        @(posedge sysClk_tb); //Start of tick16
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick17
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick18
        sigA_tb = 1'b1;
        @(posedge sysClk_tb); //Start of tick19
        sigA_tb = 1'b1;
        @(posedge sysClk_tb); //Start of tick20
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick21
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick22
        sigA_tb = 1'b1;
        #5 outAH_expected = 1'b1;
        #5 ->testOutA;
        @(posedge sysClk_tb); //Start of tick23
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick24
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick25
        sigA_tb = 1'b0;
        @(posedge sysClk_tb);  //Start of tick25
        sigA_tb = 1'b0;
        @(posedge sysClk_tb);  //Start of tick26
        sigA_tb = 1'b1;
        @(posedge sysClk_tb);  //Start of tick27
        sigA_tb = 1'b1;
        @(posedge sysClk_tb);  //Start of tick28
        sigA_tb = 1'b0;
        @(posedge sysClk_tb);  //Start of tick29
        sigA_tb = 1'b0;
        @(posedge sysClk_tb);  //Start of tick30
        sigA_tb = 1'b1;
        #5 outAH_expected = 1'b1;
        #5 ->testOutA;
        @(posedge sysClk_tb);  //Start of tick31
        sigA_tb = 1'b0;
        @(posedge sysClk_tb);  //Start of tick32
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick33
        sigA_tb = 1'b1;
        @(posedge sysClk_tb); //Start of tick34
        sigA_tb = 1'b1;
        @(posedge sysClk_tb); //Start of tick35
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick36
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick37
        sigA_tb = 1'b0;
        #5 outAH_expected = 1'b1;
        #5 ->testOutA;
        @(posedge sysClk_tb); //Start of tick38
        sigA_tb = 1'b1;
        @(posedge sysClk_tb); //Start of tick39
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick40
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick41
        sigA_tb = 1'b1;
        @(posedge sysClk_tb); //Start of tick42
        sigA_tb = 1'b1;
        @(posedge sysClk_tb); //Start of tick43
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick44
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick45
        sigA_tb = 1'b1;
        #5 outAH_expected = 1'b1;
        #5 ->testOutA;
        @(posedge sysClk_tb); //Start of tick46
        sigA_tb = 1'b0;
        @(posedge sysClk_tb); //Start of tick47
        sigA_tb = 1'b0;
    end

//reset stimulus    
initial
    begin
        $dumpfile("sequence_detect.vcd") ;
        $dumpvars(2, sequence_detect_tb) ;
        resetL_tb = 1'b0;
        #20 outAH_expected = 1'b0;
        #5 ->testOutA;
        #50 resetL_tb = 1'b1;
        repeat (48)
        @(posedge sysClk_tb);
        $stop;
    end
    
always @(testOutA) // the events testOutA
        begin
            if(outAH_tb == outAH_expected)
                begin
                    $display($time, " VERIFIED outAH_tb=%b and  outAH_expected=%b from event testOutA", outAH_tb, outAH_expected);
                end
            else
                begin
                    $display($time, " ERROR outAH_tb=%b outAH_expected=%b  so there is a problem", outAH_tb, outAH_expected);
                end
        end 

endmodule
