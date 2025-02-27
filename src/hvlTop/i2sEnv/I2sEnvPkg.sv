`ifndef I2SENVPKG_INCLUDED_
`define I2SENVPKG_INCLUDED_

package I2sEnvPkg;
  
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  import I2sGlobalPkg::*;
  import I2sTransmitterPkg::*;
  import I2sReceiverPkg::*;

  `include "I2sEnvConfig.sv"
  `include "I2sVirtualSequencer.sv"
  `include "I2sScoreboard.sv" 
  `include "I2sEnv.sv"

endpackage : I2sEnvPkg

`endif

