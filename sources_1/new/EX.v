`timescale 1ns / 1ps



module EX(input [31:0] IMM_EX,         
          input [31:0] REG_DATA1_EX,
          input [31:0] REG_DATA2_EX,
          input [31:0] PC_EX,
          input [2:0] FUNCT3_EX,
          input [6:0] FUNCT7_EX,
          input [4:0] RD_EX,
          input [4:0] RS1_EX,
          input [4:0] RS2_EX,
          input RegWrite_EX,
          input MemtoReg_EX,
          input MemRead_EX,
          input MemWrite_EX,
          input [1:0] ALUop_EX,
          input ALUSrc_EX,
          input Branch_EX,
          input [1:0] forwardA,forwardB,
          
          input [31:0] ALU_DATA_WB,
          input [31:0] ALU_OUT_MEM,
          
          output ZERO_EX,
          output [31:0] ALU_OUT_EX,
          output [31:0] PC_Branch_EX,
          output [31:0] REG_DATA2_EX_FINAL
          );

wire [3:0] ALUinput;

wire [31:0] a, b;  //reg?

ALUcontrol get_input(ALUop_EX, FUNCT7_EX, FUNCT3_EX, ALUinput);

mux3_1 select_a(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM,
                forwardA,
                a);
                
mux3_1 select_b(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM,
                forwardB,
                b);
                
mux2_1 reg_sau_imm(REG_DATA2_EX, IMM_EX, ALUSrc_EX, REG_DATA2_EX_FINAL); 
           
ALU compute_ALU(ALUinput, a, REG_DATA2_EX_FINAL, ZERO_EX, ALU_OUT_EX);  

branch_adder compute_branch(PC_EX, IMM_EX, PC_Branch_EX);        
          
endmodule
