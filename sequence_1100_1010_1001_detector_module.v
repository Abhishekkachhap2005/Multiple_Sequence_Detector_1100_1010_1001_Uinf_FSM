`timescale 1ns / 1ps
module multiple_sequence_1100_1010_1001_detector(in,clk,reset,y);
input in,clk,reset;
output reg y;
reg [26:0] count;
reg slow_clk;

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        count <= 0;
        slow_clk <= 0;
    end
    else begin
        if(count == 50_000_000 - 1) begin  // 100 MHz → 1 Hz
            slow_clk <= ~slow_clk;
            count <= 0;
        end
        else
            count <= count + 1;
    end
end

parameter [2:0] a=3'b000,b=3'b001,c=3'b010,d=3'b011,e=3'b100,f=3'b101,g=3'b110;
reg[2:0] present_state,next_state;

always@(posedge slow_clk or posedge reset)
if(reset)present_state<=3'b000;
else present_state<=next_state;
always@(*)
case(present_state)
a:begin
  y=in?0:0;
  next_state=in?b:a;
  end
b:begin
  y=in?0:0;
  next_state=in?c:e;
  end
c:begin
  y=in?0:0;
  next_state=in?c:d;
  end
d:begin
  y=in?0:1;
  next_state=in?f:g;
  end
e:begin
  y=in?0:0;
  next_state=in?f:g;
  end
f:begin
  y=in?0:0;
  next_state=in?c:e;
  end
g:begin
  y=in?1:0;
  next_state=in?b:a;
  end
endcase
endmodule
