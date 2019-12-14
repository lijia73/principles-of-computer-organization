`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/26 09:34:21
// Design Name: 
// Module Name: CL
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


module CL(
	input [5:0] opcode,
	input zero,
	output RegDst,
	output Jump,
	output Branch,
	output MemRead,
	output MemtoReg,
	output reg [2:0] ALUOP,
	output MemWrite,
	output ALUSrc,
	output RegWrite,
	output [1:0] PCSrc
    );
	//addi lw
	assign RegDst=(opcode==6'b001000||opcode==6'b100011)?0:1;
	//j
	assign Jump=(opcode==6'b000010)?1:0;
	//beq
	assign Branch=(opcode==6'b000100)?1:0;
	//lw
	assign MemRead=(opcode==6'b100011)?1:0;
	//lw
	assign MemtoReg=(opcode==6'b100011)?1:0;
	//sw
	assign MemWrite=(opcode==6'b101011)?1:0;
	//lw sw addi
	assign ALUSrc=(opcode==6'b100011||opcode==6'b101011||opcode==6'b001000)?1:0;
	//add sub addi sll lw and or
	assign RegWrite=(opcode==6'b000000||opcode==6'b000001||opcode==6'b001000||opcode==6'b011000||opcode==6'b100011||opcode==6'b010001||opcode==6'b010011)?1:0;
	
	assign PCSrc[1]=(Jump==1)?1:0;
    assign PCSrc[0]=(Branch==1&&zero==1)?1:0;
    
	always@(opcode) begin
        case(opcode)
        //add
        6'b000000: ALUOP=3'b000;
        //sub
        6'b000001: ALUOP=3'b001;
        //addi
        6'b001000: ALUOP=3'b000;
        //sw
        6'b101011: ALUOP=3'b000;
        //lw
        6'b100011: ALUOP=3'b000;
        //beq
        6'b000100: ALUOP=3'b001;
        //sll
        6'b011000: ALUOP=3'b010;
		//and 
		6'b010001: ALUOP=3'b100;
		//or 
		6'b010011: ALUOP=3'b011;
		default:ALUOP=3'b000;
        endcase
	end
endmodule
