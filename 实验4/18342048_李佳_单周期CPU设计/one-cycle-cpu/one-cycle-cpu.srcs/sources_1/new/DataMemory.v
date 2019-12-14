`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/26 09:34:21
// Design Name: 
// Module Name: DM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DM(
	input clk,
	input [31:0] address,
	input [31:0] writedata,
	
	input MemWrite,
	input MemRead,
	
	output reg[31:0] readdata
    );
	
	reg[32:0] mem[63:0];
	
	integer i;
	initial 
	begin
		for(i=0;i<64;i=i+1) mem[i]=0;
		mem[1]=32'b00000000000000000000000000000110;
		mem[2]=32'b00000000000000000000000000001001;
	end
	
	always@(posedge clk)
		if(MemWrite)
		begin
		  mem[address>>2]=writedata;
		end
		
	always@(*)
		if(MemRead)
		begin
			readdata=mem[address>>2];
		end
endmodule
