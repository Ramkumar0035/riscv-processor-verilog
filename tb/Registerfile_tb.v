`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2026 20:31:44
// Design Name: 
// Module Name: Registerfile_tb
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


`timescale 1ns/1ps

module RegisterFile_tb;

reg clk;
reg RegWrite;
reg [4:0] rs1, rs2, rd;
reg [31:0] WriteData;
wire [31:0] ReadData1, ReadData2;

RegisterFile uut (
    .clk(clk),
    .RegWrite(RegWrite),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .WriteData(WriteData),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    clk = 0;

    // Write 10 into register 5
    RegWrite = 1;
    rd = 5;
    WriteData = 10;
    #10;

    // Read from register 5
    RegWrite = 0;
    rs1 = 5;
    #10;
    $display("Reg[5] = %d", ReadData1);

    // Try writing to register 0 (should not change)
    RegWrite = 1;
    rd = 0;
    WriteData = 99;
    #10;

    rs1 = 0;
    #10;
    $display("Reg[0] = %d (should be 0)", ReadData1);

    $finish;
end

endmodule
