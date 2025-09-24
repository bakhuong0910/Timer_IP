parameter TISR=12'h18;
parameter TIER=12'h14;
parameter TCR=12'h00;
parameter TCMP0=12'h0C;
parameter TCMP1=12'h10;
parameter TDR0=12'h04;
parameter TDR1=12'h08;
task run_test();
	begin 
	fail_num=0;
	// reset value access 
	$display("reset value access");
	sys_rst_n=0;
	@(posedge sys_clk);
	sys_rst_n=1;
	@(posedge sys_clk);
	read_reg(TISR);
	check_value("TISR",32'h00000000,tim_prdata);
	// R/W access check 
	$display("R/W access check");
	@(posedge sys_clk);
	tim_pstrb=4'b1111;
	tim_pwdata=32'h203;
	write_reg(TCR);
	@(posedge sys_clk);
	tim_pwdata=32'h00000000;
	write_reg(TISR);
	@(posedge sys_clk);
	read_reg(TISR);
	check_value("TISR",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata =32'hffff_ffff;
	write_reg(TISR);
	@(posedge sys_clk);
	read_reg(TISR);
	check_value("TISR",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'h5555_5555;
	write_reg(TISR);
	@(posedge sys_clk);
	read_reg(TISR);
	check_value(TISR,32'h0000_0000,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hAAAA_AAAA;
	write_reg(TISR);
	@(posedge sys_clk);
	read_reg(TISR);
	check_value(TISR,32'h0000_0000,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hA5A5_A5A5;
	write_reg(TISR);
	@(posedge sys_clk);
	read_reg(TISR);
	check_value(TISR,32'h0000_0000,tim_prdata);
	// read after interrupt
	@(posedge sys_clk);
	sys_rst_n=1'b0;
	@(posedge sys_clk);
	sys_rst_n=1'b1;
	@(posedge sys_clk);
	$display("read after interrupt");
	tim_pstrb=4'b1111;
	@(posedge sys_clk)
	tim_pwdata=32'h203;
	write_reg(TCR);
	@(posedge sys_clk);
	tim_pwdata=32'h0000_0000;
	write_reg(TCMP1);
	write_reg(TDR0);
	write_reg(TDR1);
	@(posedge sys_clk);
	tim_pwdata=32'h05;
	write_reg(TCMP0);
	@(posedge sys_clk);
	tim_pwdata=32'h01;
	write_reg(TIER);
	repeat(20) @(posedge sys_clk);
	if(tim_int==1) begin 
		$display("=======================");
		$display("PASS: interrupt asserted ");
		$display("=======================");
	end else begin 
		$display("=======================");
		$display("FAIL: interrupt is not asserted ");
		$display("=======================");
	end
	// check in_clr when wdata[0]=r01;
	@(posedge sys_clk);
	tim_pwdata=32'hffff_fffe;
	write_reg(TISR);
	@(posedge sys_clk);
	read_reg(TISR);
	check_value(TISR,32'h0000_0001,tim_prdata);
	// write 1 to TISR to clear it 
	$display("write 1 to TISR to clear int_st");
	@(posedge sys_clk);
	tim_pwdata=32'h0000_0001;
	write_reg(TISR);
	@(posedge sys_clk);
	read_reg(TISR);
	check_value(TISR,32'h0000_0000,tim_prdata);
	// write 0 ti TIER for toggle TISR
	$display("write 0 to TIER to toggle TISR");
	@(posedge sys_clk);
	tim_pwdata=32'hffff_fffe;
	write_reg(TISR);
	@(posedge sys_clk);
	read_reg(TISR);
	check_value(TISR,32'h0000_0000,tim_prdata);







	

	if(fail_num!=0) begin 
		$display("test result is FAIL");
	end else begin 
		$display("test result is PASS");
	end
end
endtask 
