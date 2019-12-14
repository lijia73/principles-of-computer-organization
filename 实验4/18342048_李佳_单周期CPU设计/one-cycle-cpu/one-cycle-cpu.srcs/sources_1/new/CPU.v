`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/26 09:37:01
// Design Name: 
// Module Name: CPU
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


module CPU(
    input clk,
    output [15:0] q
    );
	
	wire[1:0] PCSrc;
    wire[31:0] immediate;
	wire[31:0] address;
	wire [5:0] opcode;//操作�?
	wire [4:0] rs; //源寄存器1
	wire [4:0] rt; //源寄存器2
	wire [4:0] rd; //目的寄存�?
	wire [4:0] shamt;	//移位�?
	wire [25:0] addr;	//跳转地址
    wire RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite; 
    wire[2:0] ALUOp; 
    wire[31:0] Readdata1,Readdata2,result; 
	wire zero; 
	wire[31:0] writedata=Readdata2;    
    wire[31:0] readdata;  
    wire [31:0] rwritedata;
    assign q[15:0] = {rwritedata[7:0],address[7:0]};
    //assign q[15:0] = {ALUOp,RegDst,MemRead,MemtoReg, MemWrite, ALUSrc, RegWrite,Jump,Branch,zero,4'b0101};

	PC pc(clk,PCSrc,immediate,addr,address);
	IM instructionmemory(address,opcode,rs,rt,rd,shamt,immediate,addr);
	CL control(opcode,zero,RegDst,Jump,Branch,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite,PCSrc);
	RG registers(clk,RegDst,RegWrite,opcode,rs,rt,rd,shamt,MemtoReg,result,readdata,Readdata1,Readdata2,rwritedata);
	ALU alu(Readdata1,Readdata2,ALUSrc,ALUOp,immediate,result,zero);
	DM datamemory(clk,result,writedata,MemWrite,MemRead,readdata);
	
endmodule
