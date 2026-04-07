`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2026 19:51:47
// Design Name: 
// Module Name: Programcounter
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


module ProgramCounter (
    input clk,
    input reset,
    input [31:0] NextPC,
    output reg [31:0] PC
);

always @(posedge clk or posedge reset) begin
    if (reset)
        PC <= 32'd0;
    else
        PC <= NextPC;
end

endmodule
