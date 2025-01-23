`ifndef I2SRECEIVERCONFIGCONVERTER_INCLUDED_
`define I2SRECEIVERCONFIGCONVERTER_INCLUDED_

class I2sReceiverConfigConverter extends uvm_object;
  
  extern function new(string name = "I2sReceiverConfigConverter");
//  extern static function void from_class(input i2s_slave_agent_config input_conv_h,
//                                         output i3c_transfer_cfg_s output_conv);
  extern function void do_print(uvm_printer printer);
endclass : I2sReceiverConfigConverter


function I2sReceiverConfigConverter::new(string name = "I2sReceiverConfigConverter");
  super.new(name);
endfunction : new


/*function void i2s_slave_cfg_converter::from_class(input i2s_slave_agent_config input_conv_h,
                                                   output i3c_transfer_cfg_s output_conv);
  bit target_address_width;
  
  output_conv.targetAddress = input_conv_h.targetAddress;
  output_conv.dataTransferDirection = dataTransferDirection_e'(input_conv_h.dataTransferDirection);
  output_conv.defaultReadData = input_conv_h.defaultReadData;
endfunction: from_class */


function void I2sReceiverConfigConverter::do_print(uvm_printer printer);
  super.do_print(printer);
endfunction : do_print

`endif
