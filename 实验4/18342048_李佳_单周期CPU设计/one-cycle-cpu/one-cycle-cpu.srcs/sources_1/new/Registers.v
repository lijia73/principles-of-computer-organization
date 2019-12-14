`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/26 09:34:21
// Design Name: 
// Module Name: RG
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

module RG(
	input clk,
	input RegDst,
	input RegWrite,
	input [5:0] opCode,
	input [4:0] rs, //源寄存器1
	input [4:0] rt, //源寄存器2
	input [4:0] rd,
	input [4:0] shamt,
	
	input MemtoReg,
	input [31:0] datafromALU,
	input [31:0] datafromMEM,
	
	output [31:0] Readdata1,
	output [31:0] Readdata2,
	output [31:0] rwritedata
    );
	
	reg [31:0] register[0:31]; //32位长寄存器，共32个
	wire [4:0] Writeregister;
    
	integer i;
	initial 
	begin
		for(i=0;i<32;i=i+1) register[i]=0;
	end
	
	assign Writeregister= RegDst?rd:rt;
	assign rwritedata=MemtoReg?datafromMEM:datafromALU;
	
	assign Readdata1=(opCode==6'b011000)?shamt:register[rs];
	
	assign Readdata2=register[rt];
	
	always @(posedge clk)
		if(RegWrite) register[Writeregister]=rwritedata;
		
endmodule
