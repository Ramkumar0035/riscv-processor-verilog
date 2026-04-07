`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2026 20:30:17
// Design Name: 
// Module Name: Registerfile
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


module RegisterFile (
    input clk,
    input reset,
    input RegWrite,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
);

reg [31:0] registers [31:0];
integer i;

// Combinational read
assign ReadData1 = registers[rs1];
assign ReadData2 = registers[rs2];

// Sequential write + reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] <= 32'd0;

        // preload values
        registers[1] <= 32'd5;   // x1 = 5
        registers[2] <= 32'd7;   // x2 = 7
    end
    else if (RegWrite && rd != 0) begin
        registers[rd] <= WriteData;
    end
end

endmodule
