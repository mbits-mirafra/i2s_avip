`ifndef I2SRECEIVERAGENTBFM_INCLUDED_
`define I2SRECEIVERAGENTBFM_INCLUDED_

module I2sReceiverAgentBFM(I2sInterface i2sInterface);

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import I2sGlobalPkg::*;

  I2sReceiverDriverBFM i2sReceiverDriverBFM(.clk(i2sInterface.clk),
                                            .rst(i2sInterface.rst),
                                            .wsInput(i2sInterface.rxWsInput),
                                            .wsOutput(i2sInterface.rxWsOutput),
                                            .sclkInput(i2sInterface.rxSclkInput),
                                            .sclkOutput(i2sInterface.rxSclkOutput),
                                            .sd(i2sInterface.sd));  

  I2sReceiverMonitorBFM i2sReceiverMonitorBFM(.clk(i2sInterface.clk),
                                              .rst(i2sInterface.rst),
                                              .ws(i2sInterface.ws),
                                              .sclk(i2sInterface.sclk),
                                              .sd(i2sInterface.sd)); 

  initial begin
    uvm_config_db#(virtual I2sReceiverDriverBFM)::set(null,"*","I2sReceiverDriverBFM",i2sReceiverDriverBFM);

    uvm_config_db#(virtual I2sReceiverMonitorBFM)::set(null,"*","I2sReceiverMonitorBFM",i2sReceiverMonitorBFM);
  end

  bind I2sReceiverMonitorBFM I2sReceiverAssertions ReceiverAssertion(.clk(clk),
                                                                     .rst(rst),
                                                                     .ws(ws),
							                                                       .sclk(sclk),
                                                                     .sd(sd)
                                                                    );



endmodule : I2sReceiverAgentBFM

`endif

