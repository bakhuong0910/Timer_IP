module interrupt
( 
	input wire int_en,
	input wire int_clr,
	input wire int_set,
	input wire clk,rst_n,
	output wire tim_int, 
	output reg int_st
);
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin 
		int_st <=1'b0;
	end else if(int_clr) begin
		int_st <=1'b0;
	end else if(int_set) begin 
		int_st <=1'b1;
	end
end
assign tim_int=int_en && int_st;
endmodule 

