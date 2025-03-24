`ifndef HDLTOP_INCLUDED_
`define HDLTOP_INCLUDED_

module hdlTop;

 bit clk;
 bit rst;


 initial begin
   $display("HDL TOP");
 end

 initial begin
   clk = 1'b0;
   forever #10 clk = ~clk;
 end

  initial begin
    rst =1'b1;
    @(posedge clk);
    rst = 1'b0;

   @(posedge clk);
   rst = 1'b1;

  end

  I2sInterface i2sIntf(.rst(rst),.clk(clk));
                    
  I2sTransmitterAgentBFM i2sTransmitterAgentBFM(i2sIntf); 

  I2sReceiverAgentBFM i2sReceiverAgentBFM(i2sIntf);

  initial begin
    #1300000 $finish;
  end 

endmodule : hdlTop

`endif
