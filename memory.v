module data_memory(mem_addr, M_valA, mem_read, mem_write, mem_data);

	input [63:0] mem_addr, M_valA;
	input mem_read, mem_write;
	output reg [63:0] mem_data;
	output reg dmem_error;
	reg [63:0] mem [8191:0];

	always @ (mem_addr, M_valA, mem_read, mem_write) 
	begin 
	    if (mem_write && !mem_read)
		begin
	        mem[mem_addr] = M_valA;
		end
	    if (!mem_write && mem_read)
		begin
	        mem_data = mem[mem_addr];
		end
	end

endmodule
