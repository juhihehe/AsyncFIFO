module async_fifo_mem #(parameter addr_width=4 , parameter data_width=8)(input wr_clk,
                                                                         input wr_en,
																					          input full,
																					          input [addr_width-1:0]wr_addr,
																								 input [addr_width-1:0]rd_addr,
																								 input [data_width-1:0]data_in,
																								 output [data_width-1:0]data_out);

reg [data_width-1:0] mem[0:(1<<addr_width)-1];

always@(posedge wr_clk)begin
if(wr_en&&!full)begin
mem[wr_addr]<=data_in;
end
end
assign data_out=mem[rd_addr];
endmodule