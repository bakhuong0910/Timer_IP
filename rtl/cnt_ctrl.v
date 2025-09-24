module cnt_ctrl
( 
	input wire [3:0] div_val,
	input wire tim_en,
	input wire div_en,
	input wire clk,rst_n,
	input wire halt_req,
	input wire debug_mode,
	output wire cnt_clr,
	output wire  cnt_en
);
wire halt_ack=halt_req && debug_mode;
wire count_en;
reg [7:0] int_cnt;
reg [7:0] limit;
wire cnt_rst; 
reg timer_en_d;
assign count_en=tim_en && div_en &&(div_val !=4'd0) && ~(halt_ack);
assign cnt_rst=(!tim_en) ||( !div_en) || (int_cnt==limit);

wire def_mode=tim_en && ~div_en;
wire ctrl_mode_0=tim_en && div_en &&(div_val==0);
wire ctrl_mode_other=tim_en && div_en &&(int_cnt==limit);

always @(posedge clk or negedge rst_n) begin 
	if(!rst_n) begin 
		timer_en_d<=1'd0;
	end else begin 
		timer_en_d<=tim_en;
	end
end
assign	cnt_clr=timer_en_d & ~tim_en;
assign cnt_en= ~halt_ack & (def_mode|ctrl_mode_0|ctrl_mode_other) ;
always @(*)begin  
		case(div_val)  
			4'b0000:
				limit=8'd0;
			4'b0001:  
				limit =8'b1;
			4'b0010: 
				limit =8'b0000_0011;
			4'b0011:  
				limit =8'b0000_0111;
			4'b0100:  
				limit =8'b0000_1111;
			4'b0101:  
				limit =8'b0001_1111;
			4'b0110: 
				limit =8'b0011_1111;
			4'b0111: 
				limit =8'b0111_1111;
			default: 
				limit =8'b1111_1111;
		endcase
end
always @(posedge clk or negedge rst_n) begin 
	if(!rst_n | (cnt_rst && ~halt_ack)) begin 
		int_cnt <= 8'b0000_0000;
	end else if(count_en) begin 
		int_cnt <= int_cnt+1;
	end
end
endmodule
