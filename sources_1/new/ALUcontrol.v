`timescale 1ns / 1ps



module ALUcontrol(input [1:0] ALUop,
                  input [6:0] funct7,
                  input [2:0] funct3,
                  output reg [3:0] ALUinput);

always@(*) begin                  
    casex({ALUop, funct7, funct3})
        12'b00xxxxxxx010: ALUinput = 4'b0010; //ld, sd
        12'b100100000000: ALUinput = 4'b0110; //sub
        12'b10xxxxxxx000: ALUinput = 4'b0010; //add
        12'b100000000111: ALUinput = 4'b0000; //and
        12'b100000000110: ALUinput = 4'b0001; //or
        12'b100000000100: ALUinput = 4'b0011; //xor
        12'b100000000101: ALUinput = 4'b0101; //srl, srli
        12'b100000000001: ALUinput = 4'b0100; //sll, slli
        12'b100100000101: ALUinput = 4'b1001; //sra, srai
        12'b100000000011: ALUinput = 4'b0111; //sltu
        12'b100000000010: ALUinput = 4'b1000; //slt
        12'b01xxxxxxx000: ALUinput = 4'b0110; //beq
        12'b01xxxxxxx001: ALUinput = 4'b0110; //bne
        12'b01xxxxxxx100: ALUinput = 4'b1000; //blt
        12'b01xxxxxxx101: ALUinput = 4'b1000; //bge
        12'b01xxxxxxx110: ALUinput = 4'b0111; //bltu
        12'b01xxxxxxx111: ALUinput = 4'b0111; //bgeu
    endcase                  
end
                  
endmodule
