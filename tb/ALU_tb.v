`timescale 1ns/1ps

module ALU_tb;

reg  signed [31:0] A, B;
reg  [3:0] ALU_Sel;
wire signed [31:0] Result;
wire Zero;
wire Overflow;

ALU uut (
    .A(A),
    .B(B),
    .ALU_Sel(ALU_Sel),
    .Result(Result),
    .Zero(Zero),
    .Overflow(Overflow)
);

initial begin

    $display("--------------------------------------------------");

    // Normal ADD
    A = 5; B = 2; ALU_Sel = 4'b0000; #10;
    $display("ADD        : A=%0d B=%0d Result=%0d Overflow=%b",
              A, B, Result, Overflow);

    // ADD Overflow
    A = 32'sh7FFFFFFF; B = 1; ALU_Sel = 4'b0000; #10;
    $display("ADD OV     : A=%0d B=%0d Result=%0d Overflow=%b",
              A, B, Result, Overflow);

    // Normal SUB
    A = 7; B = 3; ALU_Sel = 4'b0001; #10;
    $display("SUB        : A=%0d B=%0d Result=%0d Overflow=%b",
              A, B, Result, Overflow);

    // SUB with negative B
    A = 7; B = -3; ALU_Sel = 4'b0001; #10;
    $display("SUB (-B)   : A=%0d B=%0d Result=%0d Overflow=%b",
              A, B, Result, Overflow);

    // Negative overflow case
    A = -2147483648; B = -1; ALU_Sel = 4'b0000; #10;
    $display("NEG ADD OV : A=%0d B=%0d Result=%0d Overflow=%b",
              A, B, Result, Overflow);

    $display("--------------------------------------------------");

    $finish;

end

endmodule