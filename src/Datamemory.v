`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.03.2026 14:50:09
// Design Name: 
// Module Name: Datamemory
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


module DataMemory (
    input clk,
    input MemWrite,
    input [31:0] address,
    input [31:0] WriteData,
    output [31:0] ReadData
);

reg [31:0] memory [0:63];

assign ReadData = memory[address[7:2]];

always @(posedge clk) begin
    if (MemWrite)
        memory[address[7:2]] <= WriteData;
end
integer i;
initial begin

    for (i = 0; i < 64; i = i + 1)
        memory[i] = 0;
end

endmodule