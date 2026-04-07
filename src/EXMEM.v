`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2026 20:06:01
// Design Name: 
// Module Name: EXMEM
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


module EXMEM(
    input clk,
    input reset,

    input [31:0] ALU_Result_in,
    input [31:0] WriteData_in,
    input [4:0] rd_in,

    input MemWrite_in,
    input MemToReg_in,
    input RegWrite_in,

    output reg [31:0] ALU_Result_out,
    output reg [31:0] WriteData_out,
    output reg [4:0] rd_out,

    output reg MemWrite_out,
    output reg MemToReg_out,
    output reg RegWrite_out
);

always @(posedge clk or posedge reset) begin
    if(reset) begin
        ALU_Result_out <= 0;
        WriteData_out <= 0;
        rd_out <= 0;

        MemWrite_out <= 0;
        MemToReg_out <= 0;
        RegWrite_out <= 0;
    end
    else begin
        ALU_Result_out <= ALU_Result_in;
        WriteData_out <= WriteData_in;
        rd_out <= rd_in;

        MemWrite_out <= MemWrite_in;
        MemToReg_out <= MemToReg_in;
        RegWrite_out <= RegWrite_in;
    end
end

endmodule
