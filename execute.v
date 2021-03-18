module pipereg(out, in, stall, bubbleval, clock);

	input stall, clock;	
	parameter width = 8;
	input [width-1:0] in;	
	input [width-1:0] bubbleval;
	output reg [width-1:0] out;
	initial begin 
	     out <= bubbleval;
	end
	
	always @(posedge clock) 
	begin
	    if (!stall)
	        out <= in;
	end

endmodule

// Execute begins
module ALU(ALUA, ALUB, ALUfun, valE, new_CC);
// ALU
	parameter ALUADD = 4'h0;
	parameter ALUSUB = 4'h1;
	parameter ALUAND = 4'h2;
	parameter ALUXOR = 4'h3;

	input [63:0] ALUA;
	input [63:0] ALUB; 
	input [ 3:0] ALUfun; 
	output [63:0] valE; 
	output [ 2:0] new_CC; 

	assign valE =
	ALUfun == ALUSUB ? ALUB - ALUA :
	ALUfun == ALUAND ? ALUB & ALUA :
    	ALUfun == ALUXOR ? ALUB ^ ALUA : ALUB + ALUA;

	assign new_CC[2] = (valE == 0); 
	assign new_CC[1] = valE[63]; 
	assign new_CC[0] = 
    	ALUfun == ALUADD ? (ALUA[63] == ALUB[63]) & (ALUA[63] != valE[63]) : ALUfun == ALUSUB ?
        (~ALUA[63] == ALUB[63]) & (ALUB[63] != valE[63]) : 0;

endmodule
 
module cond(ifun, CC, Cnd);
// Branch condition
	input [3:0] ifun;
	input [2:0] CC;
	output Cnd;

	// Jump conditions.
	parameter J_YES = 4'h0;
	parameter J_LE = 4'h1;
	parameter J_L = 4'h2;
	parameter J_E = 4'h3;
	parameter J_NE = 4'h4;
	parameter J_GE = 4'h5;
	parameter J_G = 4'h6;

	wire ZF = CC[2];
	wire SF = CC[1];
	wire OF = CC[0];	
	
	assign Cnd =
	(ifun == J_YES) | 
	(ifun == J_LE & ((ZF^OF)|ZF)) | 
	(ifun == J_L & (SF^OF)) | 
	(ifun == J_E & ZF) | 
	(ifun == J_NE & ~ZF) | 
	(ifun == J_GE & (~SF^OF)) | 
	(ifun == J_G & (~SF^OF)&~ZF);

endmodule

module CC(CC, new_CC, set_CC, reset, clock);
// Condition code	
	input set_CC, reset, clock;
	input [2:0] new_CC;	
	output[2:0] CC;
	pipereg #(3) C(CC, new_CC, ~set_CC, 3'b100, clock);

endmodule
