`ifndef HDLTOP_INCLUDED_
`define HDLTOP_INCLUDED_

// Description : hdl top has a interface and controller and target agent bfm
module HdlTop;
 bit clk;
 bit rst;


 initial begin
   $display("HDL TOP");
 end

 initial begin
   clk = 1'b0;
   forever #10 clk = ~clk;
 end

 //-------------------------------------------------------
 // System Reset Generation
 // Active low reset
 //-------------------------------------------------------
 initial begin
   rst = 1'b1;

   repeat (2) begin
     @(posedge clk);
   end
   rst = 1'b0;

   repeat (2) begin
     @(posedge clk);
   end
   rst = 1'b1;
 end

 // Variable : intf_controller
 // I3C Interface Instantiation
 I2sInterface i2sTransmitter();
                    //.areset(rst),
                   // .SCL(I3C_SCL),
                   // .SDA(I3C_SDA));

 // Variable : intf_target
 // I3C Interface Instantiation
 I2sInterface i2sReceiver();
//                   .areset(rst),
//                   .SCL(I3C_SCL),
 //                  .SDA(I3C_SDA));

 // MSHA: // Implementing week0 and week1 concept
 // MSHA: // Logic for Pull-up registers using opne-drain concept
 // MSHA: assign (weak0,weak1) SCL = 1'b1;
 // MSHA: assign (weak0,weak1) SDA = 1'b1;

  // Below table shows different values for each strength .
  //
  // Strength    Value     Value displayed by display tasks
  //   supply       7         Su
  //   strong       6         St
  //   pull         5         Pu
  //   large        4         La
  //   weak         3         We
  //   medium       2         Me
  //   small        1         Sm
  //   highz        0         HiZ

  //  To display strength of a signal %v is used with the signal name
  //  assign (weak1, weak0) io_dq = (direction) ? io : 1'bz;
  //  ex: $display("%v",io_dq);
    
 // Pullup for I3C interface
// pullup p1 (I3C_SCL);
// pullup p2 (I3C_SDA);

 // Variable : controller_agent_bfm_h
 // I3C controller BFM Agent Instantiation 
 I2sTransmitterAgentBFM i2sTransmitterAgentBFM(i2sTransmitter); 




 // TODO(mshariff): 
 // The interface should have SDA and SCL along with
 // (sda_o, sda_oe and sda_i) 
 // (scl_o, scl_oe and scl_i) 
 // But no clock and reset
 //
 // The clock and reset should be given to the agent_bfm block

 
 // Variable : target_agent_bfm_h
 // I3C target BFM Agent Instantiation
 I2sReceiverAgentBFM i2sReceiverAgentBFM(i2sReceiver);

/* initial begin
   $dumpfile("i2s:if expand("%") == ""|browse confirm w|else|confirm w|endif
     _avip.vcd");
   $dumpvars();
 end*/

endmodule : HdlTop

`endif
