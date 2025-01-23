`ifndef I2SRECEIVERAGENTBFM_INCLUDED_
`define I2SRECEIVERAGENTBFM_INCLUDED_
 
module I2sReceiverAgentBFM(I2sInterface i2sInterface);
 
  import uvm_pkg::*;
`include "uvm_macros.svh"
  import I2sGlobalsPackage::*;
 
//-------------------------------------------------------
//controller driver bfm instantiation
//-------------------------------------------------------
I2sReceiverDriverBFM i2sReceiverDriverBFM();
/*(.clk(i2sInterface.CLK),
                                          .rst(i2sInterface.RST),
                                          .ws(i2sInterface.WS),
                                          .sclk(i2sInterface.SCLK),
                                          .sd(i2sInterface.SD)); */ 
 
//-------------------------------------------------------
//controller monitor bfm instatiation
//-------------------------------------------------------
I2sReceiverDriverBFM i2sReceiverMonitorBFM();
/*(.clk(i2sInterface.CLK),
                                           .rst(i2sInterface.RST),
                                           .ws(i2sInterface.WS),
                                           .sclk(i2sInterface.SCLK),
                                           .sd(i2sInterface.SD));*/
 
//-------------------------------------------------------
// Setting the virtual handle of BMFs into config_db
//-------------------------------------------------------
initial begin
  //uvm_config_db#(virtual I2sReceiverDriverBFM)::set(null,"*","I2sReceiverDriverBFM",
                                                              //i2sReceiverDriverBFM);
 
 // uvm_config_db#(virtual I2sReceiverMonitorBFM)::set(null,"*","I2sReceiverMonitorBFM",
                                                              //i2sReceiverMonitorBFM);
  end
 
initial begin
   $display("Receiver Agent BFM");
end
 
endmodule : I2sReceiverAgentBFM
 
`endif
