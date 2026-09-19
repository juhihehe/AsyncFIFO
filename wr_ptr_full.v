module wr_ptr_full #(parameter ADDR_WIDTH=4)(input wr_clk,
                                             input wr_en,
															input wr_rst,
															input [ADDR_WIDTH:0]rd_ptr_gray,//The synchronised gray rd_ptr value coming from rd_ptr module
															output [ADDR_WIDTH-1:0]wr_addr,//The address of the wr_ptr
															output reg full,//Going to tell if the memory is fully written or not 
															output reg[ADDR_WIDTH:0]wr_ptr_gray);//The value going from this module to ff synchronisers

reg [ADDR_WIDTH:0]wr_bin;
assign wr_addr=wr_bin[ADDR_WIDTH-1:0];
reg [ADDR_WIDTH:0]wr_bin_next;
reg [ADDR_WIDTH:0]wr_gray;

reg full_next;

always@(*)begin

if(wr_en&&!full)begin
wr_bin_next=wr_bin+1;
end else begin
wr_bin_next=wr_bin;
end
wr_gray=(wr_bin_next>>1)^wr_bin_next;
full_next=(wr_gray=={~rd_ptr_gray[ADDR_WIDTH:ADDR_WIDTH-1],rd_ptr_gray[ADDR_WIDTH-2:0]});
end
always@(posedge wr_clk or negedge wr_rst)begin
if(!wr_rst)begin
wr_bin<=0;
wr_ptr_gray<=0;
full<=0;
end else begin
wr_bin<=wr_bin_next;
wr_ptr_gray<=wr_gray;
full<=full_next;
end
end														
endmodule 