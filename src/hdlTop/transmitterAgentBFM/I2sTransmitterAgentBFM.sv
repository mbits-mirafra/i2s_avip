`ifndef I2STRANSMITTERAGENTBFM_INCLUDED_
`define I2STRANSMITTERAGENTBFM_INCLUDED_
 
module I2sTransmitterAgentBFM(I2sInterface i2sInterface);
 
  import uvm_pkg::*;
`include "uvm_macros.svh"
  import I2sGlobalsPackage::*;
 
//-------------------------------------------------------
//controller driver bfm instantiation
//-------------------------------------------------------
I2sTransmitterDriverBFM i2sTransmitterDriverBFM();  
 
//-------------------------------------------------------
//controller monitor bfm instatiation
//-------------------------------------------------------
I2sTransmitterMonitorBFM i2sTransmitterMonitorBFM();
 
//-------------------------------------------------------
// Setting the virtual handle of BMFs into config_db
//-------------------------------------------------------
initial begin
  uvm_config_db#(virtual I2sTransmitterDriverBFM)::set(null,"*","I2sTransmitterDriverBFM",
                                                              i2sTransmitterDriverBFM);
 
  uvm_config_db#(virtual I2sTransmitterMonitorBFM)::set(null,"*","I2sTransmitterMonitorBFM",
                                                              i2sTransmitterMonitorBFM);
  end
 
initial begin
   $display("controller Agent BFM");
end
 
endmodule : I2sTransmitterAgentBFM
 
`endif
