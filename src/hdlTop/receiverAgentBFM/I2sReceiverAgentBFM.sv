`ifndef I2SRECEIVERAGENTBFM_INCLUDED_
`define I2SRECEIVERAGENTBFM_INCLUDED_
 
module I2sReceiverAgentBFM(I2sInterface i2sInterface);
 
  import uvm_pkg::*;
`include "uvm_macros.svh"
  import I2sGlobalPkg::*;
 
I2sReceiverDriverBFM i2sReceiverDriverBFM(.clk(i2sInterface.clk),
						.rst(i2sInterface.rst),
						.wsInput(i2sInterface.wsInput),
            .wsOutput(i2sInterface.wsOutput),
            .sclkInput(i2sInterface.sclkInput),
            .sclkOutput(i2sInterface.sclkOutput),
            .sd(i2sInterface.sd));  

I2sReceiverMonitorBFM i2sReceiverMonitorBFM(.clk(i2sInterface.clk),
						.rst(i2sInterface.rst),
						.ws(i2sInterface.ws),
            .wsOutput(i2sInterface.wsOutput),
            .sclk(i2sInterface.sclk),
            .sclkOutput(i2sInterface.sclkOutput),
            .sd(i2sInterface.sd)); 
 
initial begin
  uvm_config_db#(virtual I2sReceiverDriverBFM)::set(null,"*","I2sReceiverDriverBFM",i2sReceiverDriverBFM);
 
 uvm_config_db#(virtual I2sReceiverMonitorBFM)::set(null,"*","I2sReceiverMonitorBFM",i2sReceiverMonitorBFM);
  end
 
 
endmodule : I2sReceiverAgentBFM
 
`endif
