module counter 
(
	input wire tdr0_wr_sel,
	input wire tdr1_wr_sel,
	input wire clk,rst_n,
	input wire [31:0] wdata,
	input wire cnt_en,
	input wire count_clr,
	output wire [63:0] cnt
);

reg [31:0] reg_tdr0;
reg [31:0] reg_tdr1;
always @(posedge clk or negedge rst_n) begin 
	if(!rst_n) begin 
		{reg_tdr1,reg_tdr0}<=64'h0000_0000_0000_0000;
	end
	else begin 
		if(count_clr) begin 
			{reg_tdr1,reg_tdr0}<= 64'h0000_0000_0000_0000;
		end 
		else if (tdr0_wr_sel) begin 
			reg_tdr0<=wdata;
		end
		else if (tdr1_wr_sel) begin 
			reg_tdr1<=wdata;
		end 
		else begin 
			if(cnt_en) begin  
				{reg_tdr1,reg_tdr0} <= {reg_tdr1,reg_tdr0}+1;
			end
		end
	end
end
assign cnt={reg_tdr1,reg_tdr0};

endmodule
