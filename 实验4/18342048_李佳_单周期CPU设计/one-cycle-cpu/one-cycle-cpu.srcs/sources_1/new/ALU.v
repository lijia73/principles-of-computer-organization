`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/26 09:34:21
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] ReadData1,
    input [31:0] ReadData2,
	
	input ALUSrc,
	input [2:0] ALUOP,
	input [31:0] immediate,
	
	output reg [31:0]result,
	output zero
    );
	initial
	begin
	   result=0;
	end
	
	wire [31:0] a,b;
	assign a=ReadData1;
	assign b=ALUSrc?immediate:ReadData2;
	assign zero=(result==0)?1:0;
	always @ (*)
	begin
		case(ALUOP)
			3'b000:
			begin
				result=a+b;
			end
			3'b001:
			begin
				result=a-b;
			end
			3'b010:
			begin
				result=b<<a;
			end
			3'b011:
			begin
				result=a|b;
			end
			3'b100:
			begin
				result=a&b;
			end
			3'b101:
			begin
				result=(a<b)?1:0;
			end
			3'b110:
			begin
				result=(((a<b) && (a[31] == b[31] )) ||( ( a[31] ==1 && b[31] == 0))) ? 1:0;
			end
			3'b111:
			begin
				result=a^b;
			end
			default:
			     result=0;
		endcase
	end
endmodule
