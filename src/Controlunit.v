`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2026 18:03:37
// Design Name: 
// Module Name: Controlunit
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


module ControlUnit (
    input  [6:0] opcode,
    input  [6:0] funct7,
    input  [2:0] funct3,
    output reg RegWrite,
    output reg ALUSrc,
    output reg MemToReg,
    output reg MemWrite,
    output reg Branch,
    output reg [3:0] ALU_Sel
);

always @(*) begin

    // Default values
    Branch = 0;
    RegWrite = 0;
    ALUSrc   = 0;
    MemToReg = 0;
    MemWrite = 0;
    ALU_Sel  = 4'b0000;

   case (opcode)

    7'b0110011: begin  // R-type (ADD / SUB)
        RegWrite = 1;
        ALUSrc   = 0;
        MemToReg = 0;
        MemWrite = 0;
        Branch   = 0;

        if (funct7 == 7'b0000000)
            ALU_Sel = 4'b0000; // ADD
        else if (funct7 == 7'b0100000)
            ALU_Sel = 4'b0001; // SUB
    end

    7'b0000011: begin   // LOAD instructions
    if (funct3 == 3'b010) begin   // LW
        RegWrite = 1;
        ALUSrc   = 1;
        MemToReg = 1;
        MemWrite = 0;
        Branch   = 0;
        ALU_Sel  = 4'b0000;
    end
    end

    7'b0100011: begin  // SW
        RegWrite = 0;
        ALUSrc   = 1;
        MemToReg = 0;
        MemWrite = 1;
        Branch   = 0;
        ALU_Sel  = 4'b0000; // address = base + offset
    end

    7'b1100011: begin  // BEQ
        RegWrite = 0;
        ALUSrc   = 0;
        MemToReg = 0;
        MemWrite = 0;
        Branch   = 1;
        ALU_Sel  = 4'b0001; // SUB for comparison
    end

endcase
end

endmodule