module timer_top
(
	input wire sys_clk,sys_rst_n,
	input wire dbg_mode,
	input wire tim_psel,tim_penable,tim_pwrite,
	input reg[31:0] tim_pwdata,
	input reg [3:0] tim_pstrb,
	input reg [11:0] tim_paddr,
	output wire tim_pready,
	output wire [31:0] tim_prdata,
	output wire tim_pslverr,
	output wire tim_int
);
wire 		wr_en;
wire 		rd_en;
wire [3:0]	div_val;
wire 		div_en;
wire 		int_set;
wire		int_clr;
wire 		int_en;
wire 		cnt_en;
wire 		int_st;
wire [63:0]	cnt;
wire [31:0]	wdata;
wire 		tim_en;
wire		cnt_clr;
wire		halt_req;
wire 		tdr0_wr_sel;
wire 		tdr1_wr_sel;
apb_slave u_apb_slave(.pclk(sys_clk),.prst_n(sys_rst_n),.psel(tim_psel),.penable(tim_penable),.pslverr(tim_pslverr),.pwrite(tim_pwrite),.pwdata(tim_pwdata),.pstrb(tim_pstrb),.pready(tim_pready),.timer_en(tim_en),.div_en(div_en),.div_val(div_val),.paddr(tim_paddr),.wr_en(wr_en),.rd_en(rd_en));
register_file u_register(.clk(sys_clk),.rst_n(sys_rst_n),.wr_en(wr_en),.dbg_mode(dbg_mode),.halt_req(halt_req),.rd_en(rd_en),.pstrb(tim_pstrb),.addr(tim_paddr),.wdata(tim_pwdata),.int_st(int_st),.int_set(int_set),.rdata(tim_prdata),.int_en(int_en),.int_clr(int_clr),.div_val(div_val),.div_en(div_en),.timer_en(tim_en),.tdr0_wr_sel(tdr0_wr_sel),.tdr1_wr_sel(tdr1_wr_sel),.wdata_counter(wdata),.cnt(cnt));
cnt_ctrl u_cnt_ctrl(.clk(sys_clk),.rst_n(sys_rst_n),.div_val(div_val),.tim_en(tim_en),.div_en(div_en),.cnt_clr(cnt_clr),.halt_req(halt_req),.debug_mode(dbg_mode),.cnt_en(cnt_en));
counter u_counter(.clk(sys_clk),.rst_n(sys_rst_n),.count_clr(cnt_clr),.tdr0_wr_sel(tdr0_wr_sel),.tdr1_wr_sel(tdr1_wr_sel),.wdata(wdata),.cnt_en(cnt_en),.cnt(cnt));
interrupt u_interrupt(.clk(sys_clk),.rst_n(sys_rst_n),.int_en(int_en),.int_set(int_set),.int_clr(int_clr),.int_st(int_st),.tim_int(tim_int));

endmodule

