`timescale 1ns / 1ps

module InstructionMemory (
    input  [31:0] address,
    output [31:0] instruction
);

reg [31:0] memory [0:15];

initial begin

// Program with NOPs for pipeline safety

memory[0] = 32'h002081B3; // ADD x3,x1,x2

memory[1] = 32'h00000013; // NOP
memory[2] = 32'h00000013; // NOP

memory[3] = 32'h00302023; // SW x3,0(x0)

memory[4] = 32'h00000013; // NOP

memory[5] = 32'h00002283; // LW x5,0(x0)

memory[6] = 32'h00000013; // NOP
memory[7] = 32'h00000013; // NOP

end

assign instruction = memory[address[5:2]];

endmodule