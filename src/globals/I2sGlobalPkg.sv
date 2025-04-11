`ifndef I2SGLOBALSPKG_INCLUDED_
`define I2SGLOBALSPKG_INCLUDED_

package I2sGlobalPkg;


parameter int DATA_WIDTH=8;

parameter int MAXIMUM_SIZE=4;

parameter logic WS_DEFAULT=1'bx;

typedef enum int{
    MONO= 1,
    STEREO= 2
} numOfChannelsEnum;

typedef enum bit{
    TRUE=1'b1,
    FALSE=1'b0
} hasCoverageEnum;

typedef enum bit {
    MSB_FIRST = 1'b0,
    LSB_FIRST = 1'b1
  } dataTransferDirectionEnum;

typedef enum bit[1:0]{
    TX_MASTER=2'b00,
    TX_SLAVE=2'b01,
    RX_MASTER=2'b10,
    RX_SLAVE=2'b11
  }modeTypeEnum;


  typedef enum bit[31:0] {
    KHZ_8=8000,
    KHZ_16=16000,
    KHZ_24=24000,
    KHZ_32=32000,
    KHZ_48=48000,
    KHZ_96=96000,
    KHZ_192=192000
  }clockrateFrequencyEnum;

  typedef enum bit[31:0] {
    WS_PERIOD_2_BYTE = 16,
    WS_PERIOD_4_BYTE=32,
    WS_PERIOD_6_BYTE=48,
    WS_PERIOD_8_BYTE=64,
    WS_PERIOD_INVALID= 128
  } wordSelectPeriodEnum;

  typedef enum{
    BITS_8  = 8, 
    BITS_16 =16,
    BITS_24 =24,
    BITS_32 =32,
    BITS_INVALID = 64
   }numOfBitsTransferEnum;

typedef struct {
   bit[1:0]mode;
    int clockratefrequency; 
    int wordSelectPeriod;
    int clockPeriod;
    int sclkFrequency;
    bit Sclk;
    int numOfChannels;
    bit dataTransferDirection;
  //  int delayFortxSd;
  //  int delayFortxWs;
  } i2sTransferCfgStruct;  

  typedef struct {
    bit [DATA_WIDTH-1:0]sdLeftChannel[MAXIMUM_SIZE];
    bit [DATA_WIDTH-1:0]sdRightChannel[MAXIMUM_SIZE];
    logic ws;
    int numOfBitsTransfer;
   }i2sTransferPacketStruct;


typedef enum int{
    RESET_DEACTIVATED,
    RESET_ACTIVATED,
    IDLE,
    LEFT_CHANNEL,
    RIGHT_CHANNEL
   }i2sStateEnum;
 
endpackage:I2sGlobalPkg

`endif
