`timescale 1ns / 1ps
module traffic_lights( clk,m1,m2,mt,ct,anode,cathode );
input clk;
output reg[2:0]m1,m2,mt,ct;
output reg[7:0]anode,cathode;
reg clk1=0;
reg [2:0]sec=0;
integer count=1;
reg [2:0]cstate=3'b000;
wire[7:0]ca1;
initial anode=8'b11111110;
parameter s0=3'b000;
parameter s1=3'b001;
parameter s2=3'b010;
parameter s3=3'b011;
parameter s4=3'b100;
parameter s5=3'b101;
parameter s6=3'b110;
always@(posedge clk)
begin 
    count<=count+1;
    if(count==50000000)begin
    clk1<=~clk1;
    count<=0;end
    else
     clk1<=clk1;
end
always@(posedge clk1)
begin
 case(cstate)
 s0:
 begin
        if(sec==1)
        begin
            cstate=s1;
            sec=0;
        end
        else 
        begin
            cstate=s0;
            sec=sec+1;
        end
    end
 s1:
 begin
    if(sec==5)
    begin
        cstate=s2;
        sec=0;
    end
    else
    begin
    cstate=s1;
    sec=sec+1;
    end
   end

 s2:begin
    if(sec==2)begin
    cstate=s3;
    sec=0;end
    else begin
    cstate=s2;
    
    sec=sec+1;end
    end

 s3:begin
    if(sec==5)begin
    cstate=s4;
    sec=0;end
    else begin
    cstate=s3;
    
    sec=sec+1;end
    end
    
 s4:begin
    if(sec==2)begin
    cstate=s5;
    sec=0;end
    else begin
    cstate=s4;
    sec=sec+1;end
    end

 s5:begin
    if(sec==5)begin
    cstate=s6;
    sec=0;end
    else begin
    cstate=s5;
    sec=sec+1;end
    end

 s6:begin
    if(sec==2)begin
    cstate=s0;
    sec=0;end
    else begin
    cstate=s6;
   
    sec=sec+1;end
    end
endcase
end

always@(posedge clk1)
begin
 case(cstate)
 s0:begin
    m1=3'b000;
    m2=3'b000;
    mt=3'b000;
    ct=3'b000;
    end
 s1:begin
    m1=3'b001;
    m2=3'b001;
    mt=3'b100;
    ct=3'b100;
    end

 s2:begin  
    m1=3'b001;
    m2=3'b010;
    mt=3'b100;
    ct=3'b100;
    end

 s3:begin
    
    
    m1=3'b001;
    m2=3'b100;
    mt=3'b001;
    ct=3'b100;
    
    
    end
    
 s4:
 begin
    m1=3'b010;
    m2=3'b100;
    mt=3'b010;
    ct=3'b100;   
 end

 s5:begin
    
    m1=3'b100;
    m2=3'b001;
    mt=3'b100;
    ct=3'b001;
    
    
    end

 s6:begin
   
    m1=3'b100;
    m2=3'b010;
    mt=3'b100;
    ct=3'b010;
    
   
    end
endcase
end




sevensegment se1(clk,sec,ca1);
always@(posedge clk1) cathode = ca1;
endmodule

module sevensegment(clk,in,out);
input clk;
input[2:0]in;
output reg[7:0]out;
always@(posedge clk)
begin
  case(in)
  0:out<=8'b00000011;
  1:out=8'b10011111;
  2:out=8'b00100101;
  3:out=8'b00001101;
  4:out=8'b10011001;
  5:out=8'b01001001;
  6:out=8'b01000001;
  7:out=8'b00011111;
  default:out=8'b00000011;
  endcase
end
endmodule
