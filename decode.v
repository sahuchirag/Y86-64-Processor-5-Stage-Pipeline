module cenrreg(out, in, enable, reset, resetval, clock);

	input clock;
	input [width-1:0] in;
	input enable, reset;
	input [width-1:0] resetval;
	output [width-1:0] out;	
	parameter width = 8;
	reg [width-1:0] out;
	
	always @(posedge clock) 
	begin
		if (reset)
		        out <= resetval;
		else if (enable)
		        out <= in;
	end

endmodule


module regfile(dstE, valE, dstM, valM, srcA, valA, srcB, valB, reset, clock, rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);
// Register file

// Registers as per HCL
	parameter RRAX = 4'h0;
	parameter RRCX = 4'h1;
	parameter RRDX = 4'h2;
	parameter RRBX = 4'h3;
	parameter RRSP = 4'h4;
	parameter RRBP = 4'h5;
	parameter RRSI = 4'h6;
	parameter RRDI = 4'h7;
	parameter R8 = 4'h8;
	parameter R9 = 4'h9;
	parameter R10 = 4'ha;
	parameter R11 = 4'hb;
	parameter R12 = 4'hc;
	parameter R13 = 4'hd;
	parameter R14 = 4'he;
	parameter RRNONE = 4'hf;

	input reset, clock;
	input [ 3:0] dstE;
	input [ 3:0] dstM;	
	input [63:0] valE;	
	input [63:0] valM;
	input [ 3:0] srcA;
	input [ 3:0] srcB;
	output [63:0] valA;	
	output [63:0] valB;
	reg temp = 1'b0;
// Output for each register
	output [63:0] rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14;

	wire [63:0] rax_dat, rcx_dat, rdx_dat, rbx_dat, rsp_dat, rbp_dat, rsi_dat, rdi_dat, r8_dat, r9_dat, r10_dat, r11_dat, r12_dat, r13_dat, r14_dat; // Input data for each register


	wire rax_wrt, rcx_wrt, rdx_wrt, rbx_wrt, rsp_wrt, rbp_wrt, rsi_wrt, rdi_wrt, r8_wrt, r9_wrt, r10_wrt, r11_wrt, r12_wrt, r13_wrt, r14_wrt; // Input write controls for each register

	cenrreg #(64) rax_reg(rax, rax_dat, rax_wrt, temp, 64'b0, clock);
	cenrreg #(64) rcx_reg(rcx, rcx_dat, rcx_wrt, temp, 64'b0, clock);
	cenrreg #(64) rdx_reg(rdx, rdx_dat, rdx_wrt, temp, 64'b0, clock);
	cenrreg #(64) rbx_reg(rbx, rbx_dat, rbx_wrt, temp, 64'b0, clock);
	cenrreg #(64) rsp_reg(rsp, rsp_dat, rsp_wrt, temp, 64'b0, clock);
	cenrreg #(64) rbp_reg(rbp, rbp_dat, rbp_wrt, temp, 64'b0, clock);
	cenrreg #(64) rsi_reg(rsi, rsi_dat, rsi_wrt, temp, 64'b0, clock);
	cenrreg #(64) rdi_reg(rdi, rdi_dat, rdi_wrt, temp, 64'b0, clock);
	cenrreg #(64) r8_reg(r8, r8_dat, r8_wrt, temp, 64'b0, clock);
	cenrreg #(64) r9_reg(r9, r9_dat, r9_wrt, temp, 64'b0, clock);
	cenrreg #(64) r10_reg(r10, r10_dat, r10_wrt, temp, 64'b0, clock);
	cenrreg #(64) r11_reg(r11, r11_dat, r11_wrt, temp, 64'b0, clock);
	cenrreg #(64) r12_reg(r12, r12_dat, r12_wrt, temp, 64'b0, clock);
	cenrreg #(64) r13_reg(r13, r13_dat, r13_wrt, temp, 64'b0, clock);
	cenrreg #(64) r14_reg(r14, r14_dat, r14_wrt, temp, 64'b0, clock);


	assign valA =
	srcA == RRAX ? rax :
	srcA == RRCX ? rcx :
	srcA == RRDX ? rdx :
	srcA == RRBX ? rbx :
	srcA == RRSP ? rsp :
	srcA == RRBP ? rbp :
	srcA == RRSI ? rsi :
	srcA == RRDI ? rdi :
	srcA == R8 ? r8 :
	srcA == R9 ? r9 :
	srcA == R10 ? r10 :
	srcA == R11 ? r11 :
	srcA == R12 ? r12 :
	srcA == R13 ? r13 :
	srcA == R14 ? r14 : 0;

	assign valB =
	srcB == RRAX ? rax :
	srcB == RRCX ? rcx :
	srcB == RRDX ? rdx :
	srcB == RRBX ? rbx :
	srcB == RRSP ? rsp :
	srcB == RRBP ? rbp :
	srcB == RRSI ? rsi :
	srcB == RRDI ? rdi :
	srcB == R8 ? r8 :
	srcB == R9 ? r9 :
	srcB == R10 ? r10 :
	srcB == R11 ? r11 :
	srcB == R12 ? r12 :
	srcB == R13 ? r13 :
	srcB == R14 ? r14 : 0;

	
	assign rax_wrt = dstM == RRAX | dstE == RRAX;
	assign rcx_wrt = dstM == RRCX | dstE == RRCX;
	assign rdx_wrt = dstM == RRDX | dstE == RRDX;
	assign rbx_wrt = dstM == RRBX | dstE == RRBX;
	assign rsp_wrt = dstM == RRSP | dstE == RRSP;
	assign rbp_wrt = dstM == RRBP | dstE == RRBP;
	assign rsi_wrt = dstM == RRSI | dstE == RRSI;
	assign rdi_wrt = dstM == RRDI | dstE == RRDI;
	assign r8_wrt = dstM == R8 | dstE == R8;
	assign r9_wrt = dstM == R9 | dstE == R9;
	assign r10_wrt = dstM == R10 | dstE == R10;
	assign r11_wrt = dstM == R11 | dstE == R11;
	assign r12_wrt = dstM == R12 | dstE == R12;
	assign r13_wrt = dstM == R13 | dstE == R13;
	assign r14_wrt = dstM == R14 | dstE == R14;

	assign rax_dat = dstM == RRAX ? valM : valE;
	assign rcx_dat = dstM == RRCX ? valM : valE;
	assign rdx_dat = dstM == RRDX ? valM : valE;
	assign rbx_dat = dstM == RRBX ? valM : valE;
	assign rsp_dat = dstM == RRSP ? valM : valE;
	assign rbp_dat = dstM == RRBP ? valM : valE;
	assign rsi_dat = dstM == RRSI ? valM : valE;
	assign rdi_dat = dstM == RRDI ? valM : valE;
	assign r8_dat = dstM == R8 ? valM : valE;
	assign r9_dat = dstM == R9 ? valM : valE;
	assign r10_dat = dstM == R10 ? valM : valE;
	assign r11_dat = dstM == R11 ? valM : valE;
	assign r12_dat = dstM == R12 ? valM : valE;
	assign r13_dat = dstM == R13 ? valM : valE;
	assign r14_dat = dstM == R14 ? valM : valE;

endmodule
