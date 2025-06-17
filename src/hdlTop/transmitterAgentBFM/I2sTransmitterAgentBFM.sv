`ifndef I2STRANSMITTERAGENTBFM_INCLUDED_
`define I2STRANSMITTERAGENTBFM_INCLUDED_

module I2sTransmitterAgentBFM(I2sInterface i2sInterface);

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import I2sGlobalPkg::*;

  I2sTransmitterDriverBFM i2sTransmitterDriverBFM(.clk(i2sInterface.clk),
                                                  .rst(i2sInterface.rst),
                                                  .wsInput(i2sInterface.ws),
                                                  .wsOutput(i2sInterface.txWsOutput),
                                                  .sclkInput(i2sInterface.sclk),
                                                  .sclkOutput(i2sInterface.txSclkOutput),
                                                  .sd(i2sInterface.sd));  

  I2sTransmitterMonitorBFM i2sTransmitterMonitorBFM(.clk(i2sInterface.clk),
                                                    .rst(i2sInterface.rst),
                                                    .ws(i2sInterface.ws),
                                                    .sclk(i2sInterface.sclk),
                                                    .sd(i2sInterface.sd));  

  initial begin
    uvm_config_db#(virtual I2sTransmitterDriverBFM )::set(null,"*","I2sTransmitterDriverBFM",
                                                          i2sTransmitterDriverBFM);

    uvm_config_db#(virtual I2sTransmitterMonitorBFM)::set(null,"*","I2sTransmitterMonitorBFM",
                                                          i2sTransmitterMonitorBFM);
  end

  bind I2sTransmitterMonitorBFM I2sTransmitterAssertions TransmitterAssertions(.clk(clk),
                                                                                .rst(rst),
                                                                                .ws(ws),
										.sclk(sclk),							                  	                                                                  .sd(sd));

  initial begin
    $display("Transmitter Agent BFM");
  end

endmodule : I2sTransmitterAgentBFM 
`endif

