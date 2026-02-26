`timescale 1ns / 1ps
module multiple_sequence_1100_1010_1001_detector_tb();
reg clk,reset,in;
wire y;
multiple_sequence_1100_1010_1001_detector dut (in,clk,reset,y);
always #5 clk=~clk;
initial begin
clk='b0; reset=1'b1;
#7 reset=1'b0;#1 in=0;
#4 in=1;#10 in=0;#10 in=1;#10 in=0;
#10 in=1;#5 in=0;#5 in=1;#20 in=0;#20 in=1;
#10 in=0;#20 in=1;#10 in=0;

# 20 $finish;
end
endmodule
