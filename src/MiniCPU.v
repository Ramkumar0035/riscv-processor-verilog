module MiniCPU (
    input clk,
    input reset
);

// ---------------- PC wires ----------------
wire [31:0] PC;
wire [31:0] NextPC;
wire [31:0] PC_plus4;

// ---------------- Instruction ----------------
wire [31:0] instruction;

// ---------------- IF/ID ----------------
wire [31:0] IFID_instruction;

// ---------------- Control signals ----------------
wire RegWrite;
wire ALUSrc;
wire MemToReg;
wire MemWrite;
wire Branch;
wire [3:0] ALU_Sel;

// ---------------- Datapath ----------------
wire [31:0] ReadData1, ReadData2;
wire [31:0] Imm;

// ---------------- ID/EX ----------------
wire [31:0] IDEX_A;
wire [31:0] IDEX_B;
wire [31:0] IDEX_Imm;
wire [4:0]  IDEX_rd;

wire IDEX_MemWrite;
wire IDEX_MemToReg;
wire IDEX_RegWrite;
wire [3:0] IDEX_ALU_Sel;

// ---------------- EX stage ----------------
wire [31:0] ALU_Result;
wire Zero;

// ---------------- EX/MEM ----------------
wire [31:0] EXMEM_ALU_Result;
wire [31:0] EXMEM_WriteData;
wire [4:0]  EXMEM_rd;

wire EXMEM_MemWrite;
wire EXMEM_MemToReg;
wire EXMEM_RegWrite;

// ---------------- MEM stage ----------------
wire [31:0] ReadDataMem;

// ---------------- MEM/WB ----------------
wire [31:0] MEMWB_ReadData;
wire [31:0] MEMWB_ALU_Result;
wire [4:0]  MEMWB_rd;

wire MEMWB_MemToReg;
wire MEMWB_RegWrite;

// ---------------- Writeback ----------------
wire [31:0] WriteData;



// ================= PROGRAM COUNTER =================

ProgramCounter PC_unit (
    .clk(clk),
    .reset(reset),
    .NextPC(NextPC),
    .PC(PC)
);

assign PC_plus4 = PC + 4;
assign NextPC = PC_plus4;



// ================= INSTRUCTION MEMORY =================

InstructionMemory IM (
    .address(PC),
    .instruction(instruction)
);



// ================= IF/ID PIPELINE =================

IF_ID ifid (
    .clk(clk),
    .reset(reset),
    .instr_in(instruction),
    .instr_out(IFID_instruction)
);



// ================= IMMEDIATE GENERATOR =================

assign Imm = {{20{IFID_instruction[31]}}, IFID_instruction[31:20]};



// ================= CONTROL UNIT =================

ControlUnit CU (
    .opcode(IFID_instruction[6:0]),
    .funct7(IFID_instruction[31:25]),
    .funct3(IFID_instruction[14:12]),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemToReg(MemToReg),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .ALU_Sel(ALU_Sel)
);



// ================= REGISTER FILE =================

RegisterFile RF (
    .clk(clk),
    .reset(reset),
    .RegWrite(MEMWB_RegWrite),
    .rs1(IFID_instruction[19:15]),
    .rs2(IFID_instruction[24:20]),
    .rd(MEMWB_rd),
    .WriteData(WriteData),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);



// ================= ID/EX PIPELINE =================

ID_EX idex (
    .clk(clk),
    .reset(reset),

    .A_in(ReadData1),
    .B_in(ReadData2),
    .Imm_in(Imm),
    .rd_in(IFID_instruction[11:7]),

    .MemWrite_in(MemWrite),
    .MemToReg_in(MemToReg),
    .RegWrite_in(RegWrite),
    .ALU_Sel_in(ALU_Sel),

    .A_out(IDEX_A),
    .B_out(IDEX_B),
    .Imm_out(IDEX_Imm),
    .rd_out(IDEX_rd),

    .MemWrite_out(IDEX_MemWrite),
    .MemToReg_out(IDEX_MemToReg),
    .RegWrite_out(IDEX_RegWrite),
    .ALU_Sel_out(IDEX_ALU_Sel)
);



// ================= ALU =================

wire [31:0] ALU_B;

assign ALU_B = (ALUSrc) ? IDEX_Imm : IDEX_B;

ALU alu_unit (
    .A(IDEX_A),
    .B(ALU_B),
    .ALU_Sel(IDEX_ALU_Sel),
    .Result(ALU_Result),
    .Zero(Zero),
    .Overflow()
);



// ================= EX/MEM PIPELINE =================

EXMEM exmem (
    .clk(clk),
    .reset(reset),

    .ALU_Result_in(ALU_Result),
    .WriteData_in(IDEX_B),
    .rd_in(IDEX_rd),

    .MemWrite_in(IDEX_MemWrite),
    .MemToReg_in(IDEX_MemToReg),
    .RegWrite_in(IDEX_RegWrite),

    .ALU_Result_out(EXMEM_ALU_Result),
    .WriteData_out(EXMEM_WriteData),
    .rd_out(EXMEM_rd),

    .MemWrite_out(EXMEM_MemWrite),
    .MemToReg_out(EXMEM_MemToReg),
    .RegWrite_out(EXMEM_RegWrite)
);



// ================= DATA MEMORY =================

DataMemory DM (
    .clk(clk),
    .MemWrite(EXMEM_MemWrite),
    .address(EXMEM_ALU_Result),
    .WriteData(EXMEM_WriteData),
    .ReadData(ReadDataMem)
);



// ================= MEM/WB PIPELINE =================

MEM_WB memwb (
    .clk(clk),
    .reset(reset),

    .ReadData_in(ReadDataMem),
    .ALU_Result_in(EXMEM_ALU_Result),
    .rd_in(EXMEM_rd),

    .MemToReg_in(EXMEM_MemToReg),
    .RegWrite_in(EXMEM_RegWrite),

    .ReadData_out(MEMWB_ReadData),
    .ALU_Result_out(MEMWB_ALU_Result),
    .rd_out(MEMWB_rd),

    .MemToReg_out(MEMWB_MemToReg),
    .RegWrite_out(MEMWB_RegWrite)
);



// ================= WRITEBACK =================

assign WriteData = (MEMWB_MemToReg) ? MEMWB_ReadData : MEMWB_ALU_Result;


endmodule