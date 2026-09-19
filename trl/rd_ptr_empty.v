module rd_ptr_empty #(parameter ADDR_WIDTH=4)(input rd_clk,
                                              input rd_en,
															 input rd_rst,
															 input [ADDR_WIDTH:0]wr_ptr_gray,
															 output [ADDR_WIDTH-1:0]rd_addr,
															 output reg [ADDR_WIDTH:0]rd_ptr_gray,
															 output reg empty);
															 
															 
reg [ADDR_WIDTH:0]rd_bin;
reg [ADDR_WIDTH:0]rd_bin_next;
reg empty_next;
reg [ADDR_WIDTH:0]rd_ptr_gray_next;
assign rd_addr=rd_bin[ADDR_WIDTH-1:0];
always@(*)begin
if(rd_en&&!empty)begin
   rd_bin_next=rd_bin+1'b1;
end else begin
  rd_bin_next=rd_bin;
end
rd_ptr_gray_next=(rd_bin_next>>1)^rd_bin_next;
empty_next=(rd_ptr_gray_next==wr_ptr_gray);
end
always@(posedge rd_clk or negedge rd_rst)begin
if(!rd_rst)begin
rd_bin<=0;
empty<=1;
rd_ptr_gray<=0;
end else begin
rd_bin<=rd_bin_next;
rd_ptr_gray<=rd_ptr_gray_next;
empty<=empty_next;
end
end
endmodule
