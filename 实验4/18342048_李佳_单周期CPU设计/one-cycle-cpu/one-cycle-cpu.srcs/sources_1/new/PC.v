`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/26 09:34:21
// Design Name: 
// Module Name: PC
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


module PC(
	input clk,
	input [1:0] PCSrc,
	input [31:0] immediate,//立即�?
    input [25:0] addr,//2-27位跳转地�?
    output reg[31:0] address//输出地址
    );
	initial
		begin
			address=0;
		end
	always@(posedge clk)
	begin
	   case(PCSrc)
		2'b00:address=address+4;
		2'b01:address=address+4+immediate*4;
		2'b10:
		  begin
		      address=address+4;
			  address={address[31:28],addr[25:0],1'b0,1'b0};
		  end
		default:address=address+4;
	   endcase
	end
endmodule
