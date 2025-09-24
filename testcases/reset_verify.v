`timescale 1ns/1ns
parameter TCR_addr=12'h00;
parameter TDR0_addr=12'h04;
parameter TDR1_addr=12'h08;
parameter TCMP0_addr=12'h0C;
parameter TCMP1_addr=12'h10;
parameter TIER_addr=12'h14;
parameter TISR_addr=12'h18;
parameter THCSR_addr=12'h1C;
task run_test; 
	begin
		fail_num=0; 
		$display("====PAT NAME: RESET VERIFY===========");
	#1
	//Init  test 
	sys_rst_n=0 ; 
	repeat(2) @(posedge sys_clk);
	sys_rst_n=1;
	@(posedge sys_clk);
	tim_pstrb=4'b1111;
	read_reg(TCR_addr);
	check_value("TCR",32'h00000100,tim_prdata);
	@(posedge sys_clk);
	read_reg(TDR0_addr);
	check_value("TDR0",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	read_reg(TDR1_addr);
	check_value("TDR1",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	read_reg(TCMP0_addr);
	check_value("TCMP0",32'hffffffff,tim_prdata);
	@(posedge sys_clk);
	read_reg(TCMP1_addr);
	check_value("TCMP1",32'hffffffff,tim_prdata);
	@(posedge sys_clk);
	read_reg(TIER_addr);
	check_value("TIER",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	read_reg(TISR_addr);
	check_value("TISR",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	read_reg(THCSR_addr);
	check_value("THCSR",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	//while counting
	$display("reset check while counting");
	sys_rst_n=0;
	tim_pstrb=4'b1111;
	tim_pwdata=32'h1;
	write_reg(TCR_addr);
	@(posedge sys_clk);
	sys_rst_n=1;	
	@(posedge sys_clk);
	read_reg(TCR_addr);
	check_value("TCR",32'h00000100,tim_prdata);
	@(posedge sys_clk);
	read_reg(TDR0_addr);
	check_value("TDR0",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	read_reg(TDR1_addr);
	check_value("TDR1",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	read_reg(TCMP0_addr);
	check_value("TCMP0",32'hffffffff,tim_prdata);
	@(posedge sys_clk);
	read_reg(TCMP1_addr);
	check_value("TCMP1",32'hffffffff,tim_prdata);
	@(posedge sys_clk);
	read_reg(TIER_addr);
	check_value("TIER",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	read_reg(TISR_addr);
	check_value("TISR",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	read_reg(THCSR_addr);
	check_value("THCSR",32'h00000000,tim_prdata);

	@(posedge sys_clk);
	if(fail_num!=0) begin
		$display("test result is FAILED");
	end else begin
		$display("test result is PASSED");
	end
	end
endtask
