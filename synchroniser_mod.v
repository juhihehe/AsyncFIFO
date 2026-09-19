module synchroniser_mod #(parameter ptr_width=5)(input clk,
                                             input rst,
															input [ptr_width-1:0]gray_in_ptr,
															output reg [ptr_width-1:0]gray_out_ptr);
reg [ptr_width-1:0]imm_reg;
always@(posedge clk or negedge rst)begin
if(!rst)begin
gray_out_ptr<=0;
imm_reg<=0;
end else begin
imm_reg<=gray_in_ptr;
gray_out_ptr<=imm_reg;
end
end
endmodule