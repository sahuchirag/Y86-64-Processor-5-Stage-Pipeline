module InstructionMemory(f_pc, split_byte, align_bytes, imem_error);

	initial 
        begin
            $readmemh("./instructionencoded.mem", instruction_mem);
        end

	input [63:0] f_pc;
	reg [7:0] instruction_mem [2047:0];
	output reg[71:0] align_bytes;    
	output reg[7:0] split_byte;
        output reg imem_error;

    
    	always @(f_pc)
    	begin
		imem_error <= (f_pc < 64'd0 || f_pc > 64'd9824) ? 1'b1:1'b0;        	
		split_byte <= instruction_mem[f_pc];
        	align_bytes[71:64] <= instruction_mem[f_pc+1];
        	align_bytes[63:56] <= instruction_mem[f_pc+2];
        	align_bytes[55:48] <= instruction_mem[f_pc+3];
        	align_bytes[47:40] <= instruction_mem[f_pc+4];
        	align_bytes[39:32] <= instruction_mem[f_pc+5];
        	align_bytes[31:24] <= instruction_mem[f_pc+6];
        	align_bytes[23:16] <= instruction_mem[f_pc+7];
        	align_bytes[15:8]  <= instruction_mem[f_pc+8];
        	align_bytes[ 7:0]  <= instruction_mem[f_pc+9];
        	
     	end

endmodule

module pc_increment(pc, need_regids, need_valC, valP);
// PC increment
	input [63:0] pc;
	input need_regids, need_valC;
	output [63:0] valP;
	assign valP = pc + 1 + 8*need_valC + need_regids;

endmodule


module split(ibyte, icode, ifun);
// Break down instruction to icode and ifun
	input [7:0] ibyte;
	output [3:0] icode, ifun;
	assign ifun = ibyte[3:0];	
	assign icode = ibyte[7:4];	

endmodule


module align(ibytes, need_regids, rA, rB, valC);
// Extract immediate word from 9 bytes of instruction
	input need_regids;	
	input [71:0] ibytes;
	output [ 3:0] rA, rB;
	output [63:0] valC;
	assign rA = ibytes[71:68];
	assign rB = ibytes[67:64];
	assign valC = need_regids ? ibytes[63:0] : ibytes[71:8];

endmodule

