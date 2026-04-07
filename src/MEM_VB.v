`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2026 17:09:25
// Design Name: 
// Module Name: MEM_VB
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


module MEM_WB(
    input clk,
    input reset,

    input [31:0] ReadData_in,
    input [31:0] ALU_Result_in,
    input [4:0] rd_in,

    input MemToReg_in,
    input RegWrite_in,

    output reg [31:0] ReadData_out,
    output reg [31:0] ALU_Result_out,
    output reg [4:0] rd_out,

    output reg MemToReg_out,
    output reg RegWrite_out
);

always @(posedge clk or posedge reset) begin
    if(reset) begin
        ReadData_out <= 0;
        ALU_Result_out <= 0;
        rd_out <= 0;

        MemToReg_out <= 0;
        RegWrite_out <= 0;
    end
    else begin
        ReadData_out <= ReadData_in;
        ALU_Result_out <= ALU_Result_in;
        rd_out <= rd_in;

        MemToReg_out <= MemToReg_in;
        RegWrite_out <= RegWrite_in;
    end
end

endmodule
