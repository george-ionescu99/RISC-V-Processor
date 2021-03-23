`timescale 1ns / 1ps



module RISC_V(input clk,
              input reset,
              
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              output [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output control_sel
             );
             
reg IF_ID_write;       //semnal de scriere pentru registrul de pipeline IF_ID
reg PC_write;    //semnale de control pentru PC
wire RegWrite_WB;       //semnal de activare a scrierii in bancul de registri
wire [4:0] RD_WB;       //registrul rezultat in care se face scrierea  

wire [31:0] PC_ID;          //adresa PC a instructiunii din etapa ID
wire [31:0] INSTRUCTION_ID; //instructiunea curenta in etapa ID
wire [31:0] IMM_ID;         //valoarea calculata
wire [31:0] REG_DATA1_ID;   //valoarea primului registru sursa citit
wire [31:0] REG_DATA2_ID;   //valoarea celui de-al doilea registru sursa citit
                    
wire [2:0] FUNCT3_ID;  //funct3 din codificarea instructiunii
wire [6:0] FUNCT7_ID;  //funct7 din codificarea instructiunii
wire [6:0] OPCODE_ID;     //opcode-ul instructiunii
wire [4:0] RD_ID;      //registru destinatie
wire [4:0] RS1_ID;     //registru sursa1
wire [4:0] RS2_ID;    //registru sursa2 

wire RegWrite_ID;  //semnal pentru scrierea in bancul de registri
wire MemtoReg_ID;  //semnal pentru scrierea din memorie in registru
wire MemRead_ID;   //semnal pentru citirea din memoria de date
wire MemWrite_ID;  //semnal pentru scrierea in memoria de date
wire [1:0] ALUop_ID; //codificarea operatiei efectuate de ALU 
wire ALUSrc_ID;      //semnal pentru alegerea operanzilor in ALU
wire Branch_ID;

wire ZERO_EX;
wire [31:0] REG_DATA2_EX_FINAL;
wire [4:0] RS2_MEM;

wire [31:0] data2_MEM;
wire [31:0] ALUresult_MEM;
wire ZERO_MEM;

/////////WB
wire [31:0] DATA_MEMORY_WB, ALUresult_WB;
wire MemToReg_WB;


initial begin
    IF_ID_write = 1'b1;      
    //PCSrc = 1'b0;
    PC_write = 1'b1;    
    //PC_EX = 32'b0;  
    //RegWrite_WB = 1'b0;       
    //ALU_DATA_WB = 32'b0;
    //ALUresult_MEM = 32'b0;
    //RD_WB = 5'b0;
    //control_sel = 1'b0;    
end


RISC_V_IF_ID procesor_incepe(clk,reset,
         IF_ID_write,
         PCSrc,PC_write,
         PC_EX,
         RegWrite_WB, 
         ALU_DATA_WB,
         RD_WB,
         PC_ID,
         INSTRUCTION_ID,
         IMM_ID,
         REG_DATA1_ID,REG_DATA2_ID,
         FUNCT3_ID,
         FUNCT7_ID,
         OPCODE_ID,
         RD_ID,    
         RS1_ID,   
         RS2_ID);
         
 hazard_detection hazard(RD_ID, RS1_ID, RS2_ID, MemRead_ID,
                        PCwrite, ID_ID_write, control_sel); 
                        
control_path control(OPCODE_ID, control_sel,
                     MemRead_ID, MemToReg_ID, MemWrite_ID, RegWrite_ID, Branch_ID, ALUSrc_ID,
                     ALUop_ID);                  
         
///////////////////////////////////////////////////////////         
         
EX execute(IMM_ID,
            REG_DATA1_ID, REG_DATA2_ID,
            PC_ID,
            FUNCT3_ID,
            FUNCT7_ID,
            RD_ID,    
            RS1_ID,   
            RS2_ID,
            RegWrite_ID,
            MemtoReg_ID,
            MemRead_ID, 
            MemWrite_ID,
            ALUop_ID,
            ALUSrc_ID,
            Branch_ID,
            forwardA, forwardB,
            ALU_DATA_WB,
            ALUresult_MEM,
            ZERO_EX,
            ALU_OUT_EX,
            PC_EX,
            REG_DATA2_EX_FINAL
            );
            
forwarding forward_module(RS1_ID, RS2_ID, RD_ID, RD_WB, RegWrite_ID, RegWrite_WB,
                          forwardA, forwardB);             
            
////////////////////////////

EX_MEM_reg EX_MEM_REGISTER(clk, reset, PC_write,
                            ALU_OUT_EX, REG_DATA2_EX_FINAL,
                            MemRead_ID, MemWrite_ID,
                            ZERO_EX,
                            ALUresult_MEM, data2_MEM,
                            MemRead_MEM, MemWrite_MEM,
                            ZERO_MEM);
                            
data_memory access(clk, MemRead_MEM, MemWrite_MEM,
                    ALUresult_MEM, data2_MEM,
                    DATA_MEMORY_MEM);
                    
assign PCSrc = ZERO_MEM & Branch_ID;                    
                    
//////////////////////////////

MEM_WB_reg MEM_WB_REGISTER(clk, reset, PC_write,
                            DATA_MEMORY_MEM, ALUresult_MEM, RD_ID,
                            DATA_MEMORY_WB, ALUresult_WB, RD_WB);
                            
WB write_back(MemToReg_ID, DATA_MEMORY_WB, ALU_DATA_WB,
              RD_ID, ALU_DATA_WB, RD_WB, RegWrite_WB);                                                
             
endmodule
