`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2026 15:49:44
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
    input clk,
    input reset,

    input [31:0] A_in,
    input [31:0] B_in,
    input [31:0] Imm_in,
    input [4:0] rd_in,

    input MemWrite_in,
    input MemToReg_in,
    input RegWrite_in,
    input [3:0] ALU_Sel_in,

    output reg [31:0] A_out,
    output reg [31:0] B_out,
    output reg [31:0] Imm_out,
    output reg [4:0] rd_out,

    output reg MemWrite_out,
    output reg MemToReg_out,
    output reg RegWrite_out,
    output reg [3:0] ALU_Sel_out
);

always @(posedge clk or posedge reset) begin
    if(reset) begin
        A_out <= 0;
        B_out <= 0;
        Imm_out <= 0;
        rd_out <= 0;

        MemWrite_out <= 0;
        MemToReg_out <= 0;
        RegWrite_out <= 0;
        ALU_Sel_out <= 0;
    end
    else begin
        A_out <= A_in;
        B_out <= B_in;
        Imm_out <= Imm_in;
        rd_out <= rd_in;

        MemWrite_out <= MemWrite_in;
        MemToReg_out <= MemToReg_in;
        RegWrite_out <= RegWrite_in;
        ALU_Sel_out <= ALU_Sel_in;
    end
end

endmodule
