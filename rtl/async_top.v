module async_top #(parameter addr_width=4, parameter data_width=8)(input wr_clk,
                                                                   input wr_rst,
																						 input wr_en,
																						 
																						 input rd_clk,
																						 input rd_rst,
																						 input rd_en,
																						 
																						 input [data_width-1:0]data_in,
																						 output [data_width-1:0]data_out,
																						 
																						 output full,
																						 output empty);

wire [addr_width:0]not_sync_wr_ptr,sync_wr_ptr;
wire [addr_width:0]not_sync_rd_ptr,sync_rd_ptr;
wire [addr_width-1:0]wr_address,rd_address;
wr_ptr_full #(.ADDR_WIDTH(addr_width)) mod1(.wr_clk(wr_clk),
                                            .wr_en(wr_en),
														  .wr_rst(wr_rst),
														  .rd_ptr_gray(sync_rd_ptr),
														  .wr_addr(wr_address),
														  .full(full),
														  .wr_ptr_gray(not_sync_wr_ptr));

synchroniser_mod #(.ptr_width(addr_width+1)) mod2(.clk(rd_clk),
                                                  .rst(rd_rst),
																  .gray_in_ptr(not_sync_wr_ptr),
																  .gray_out_ptr(sync_wr_ptr));

rd_ptr_empty #(.ADDR_WIDTH(addr_width)) mod3(.rd_clk(rd_clk),
                                            .rd_en(rd_en),
														  .rd_rst(rd_rst),
														  .wr_ptr_gray(sync_wr_ptr),
														  .rd_addr(rd_address),
														  .rd_ptr_gray(not_sync_rd_ptr),
														  .empty(empty));


synchroniser_mod #(.ptr_width(addr_width+1)) mod4(.clk(wr_clk),
                                                  .rst(wr_rst),
																  .gray_in_ptr(not_sync_rd_ptr),
																  .gray_out_ptr(sync_rd_ptr));

async_fifo_mem #(.addr_width(addr_width),.data_width(data_width)) mod5 (.wr_clk(wr_clk),
                                                                        .wr_en(wr_en),
																								.full(full),
																								.wr_addr(wr_address),
																								.rd_addr(rd_address),
																								.data_in(data_in),
																								.data_out(data_out));
endmodule