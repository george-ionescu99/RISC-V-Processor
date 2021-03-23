`timescale 1ns / 1ps



module ALU(input [3:0] ALUop, //ALUinput
           input [31:0] ina, inb,
           output zero,
           output reg [31:0] out);
           
always@(*) begin
    case(ALUop)
        4'b0000: out <= ina & inb;   //and
        4'b0001: out <= ina | inb;   //or
        4'b0010: out <= ina + inb;   //add
        4'b0011: out <= ina ^ inb;  //xor
        4'b0110: out <= ina - inb;   //subtract
		//completeaza aici cu tot ce in tabelul ala, mi-a scazut ca nu le-am facut pe toate
    endcase   
end           

assign zero = (out == 0) ? 1 : 0;     
      
endmodule
