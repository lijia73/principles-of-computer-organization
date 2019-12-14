`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/30 21:03:58
// Design Name: 
// Module Name: getPCsrc
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


module getPCsrc(
    input Jump,
    input Branch,
	input zero,
    output [1:0] PCSrc
    );
    assign PCSrc[1]=(Jump==1)?1:0;
    assign PCSrc[0]=(Branch==1&&zero==1)?1:0;
endmodule
