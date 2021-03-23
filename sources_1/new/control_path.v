`timescale 1ns / 1ps



module control_path(input [6:0] opcode,
                    input control_sel,
                    output reg MemRead, MemToReg, MemWrite, RegWrite, Branch, ALUSrc,
                    output reg [1:0] ALUop);
                    
always @(*) begin
    if(control_sel == 1) begin
       MemRead = 0;
       MemToReg = 0;
       MemWrite = 0;
       Branch = 0;
       ALUSrc = 0;
       ALUop = 0; 
    end
    
    else begin
        case(opcode)
            7'b0010011:     begin // R-format - addi
                                MemRead = 0; MemToReg = 0; MemWrite = 0; RegWrite = 1;
                                Branch = 0; ALUSrc = 1; ALUop = 2'b10;
                                end  
            7'b0110011:     begin // R-format
                                MemRead = 0; MemToReg = 0; MemWrite = 0; RegWrite = 1;
                                Branch = 0; ALUSrc = 0; ALUop = 2'b10;
                                end
            7'b0000011:     begin //ld
                                MemRead = 1; MemToReg = 1; MemWrite = 0; RegWrite = 1;
                                Branch = 0; ALUSrc = 1; ALUop = 2'b00;
                                end
            7'b0100011:     begin //sd
                                MemRead = 0; MemWrite = 1; RegWrite = 0;
                                Branch = 0; ALUSrc = 1; ALUop = 2'b00;
                                end
            7'b1100011:     begin //beq
                                MemRead = 0; MemWrite = 0; RegWrite = 0;
                                Branch = 1; ALUSrc = 0; ALUop = 2'b01;
                                end                      
        endcase
    end
end                    
                    
endmodule
