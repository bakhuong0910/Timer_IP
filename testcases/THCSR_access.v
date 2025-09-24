parameter TCR=12'h00;
parameter TDR0=12'h04;
parameter TDR1=12'h08;
parameter TCMP0=12'hC;
parameter TCMP1=12'h10;
parameter TIER=12'h14;
parameter TISR=12'h18;
parameter THCSR=12'h1C;
task run_test();
	begin 
	fail_num=0;
	$display("====PAT NAME: THCSR_access=======");
	$display("reset value access");
	sys_rst_n=0;
	@(posedge sys_clk);
	sys_rst_n=1;
	@(posedge sys_clk);
	read_reg(THCSR);
	check_value("THCSR",32'h00000000,tim_prdata);
	//R/W access value check 
	@(posedge sys_clk);
	$display("R/W access value check");
	tim_pstrb=4'b1111;
	tim_pwdata=32'h0000_0000;
	write_reg(THCSR);
	@(posedge sys_clk);
	read_reg(THCSR);
	check_value("THCSR",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hffff_ffff;
	write_reg(THCSR);
	@(posedge sys_clk);
	read_reg(THCSR);
	check_value("THCSR",32'h0000_0003,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'h5555_5555;
	write_reg(THCSR);
	@(posedge sys_clk);
	read_reg(THCSR);
	check_value(THCSR,32'h0000_0003,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hffff_ffff;
	write_reg(THCSR);
	@(posedge sys_clk);
	read_reg(THCSR);
	check_value(THCSR,32'h0000_0003,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hAAAA_AAAA;
	write_reg(THCSR);
	@(posedge sys_clk);
	read_reg(THCSR);
	check_value(THCSR,32'h0000_0000,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hA5A5_A5A5;
	write_reg(THCSR);
	@(posedge sys_clk);
	read_reg(THCSR);
	check_value(THCSR,32'h0000_0003,tim_prdata);
	

	// check halt mode
	@(posedge sys_clk);
	$display("check halt mode ");
	tim_pwdata=32'h01;
	write_reg(TCR);
	repeat(2) @(posedge sys_clk);
	write_reg(THCSR);
	@(posedge sys_clk);
	read_reg(THCSR);
	check_value("THCSR",32'h00000003,tim_prdata);
	@(posedge sys_clk)
	dbg_mode=0;
	tim_pwdata=32'h01;
	write_reg(TCR);
	repeat(2) @(posedge sys_clk);
	write_reg(THCSR);
	@(posedge sys_clk);
	read_reg(THCSR);
	check_value("THCSR",32'h00000001,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'h00;
	write_reg(THCSR);
	@(posedge sys_clk);
	read_reg(THCSR);
	check_value(THCSR,32'h0000_0000,tim_prdata);
	// check hale mode when pstrb=4'b1110;
	@(posedge sys_clk);
	dbg_mode=1;
	tim_pstrb=4'b1110;
	tim_pwdata=32'h01;
	write_reg(THCSR);
	@(posedge sys_clk);
	read_reg(THCSR);
	check_value(THCSR,32'h0000_0000,tim_prdata);
	@(posedge sys_clk);
	tim_pstrb=4'b1110;
	tim_pwdata=32'h00;
	write_reg(THCSR);
	@(posedge sys_clk);
	read_reg(THCSR);
	check_value(THCSR,32'h0000_0000,tim_prdata);
	@(posedge sys_clk);
	tim_pstrb=4'b1111;
	tim_pwdata=32'h01;
	write_reg(THCSR);
	@(posedge sys_clk);
	tim_pstrb=4'b1110;
	tim_pwdata=32'h01;
	write_reg(THCSR);
	@(posedge sys_clk);
	read_reg(THCSR);
	check_value(THCSR,32'h03,tim_prdata);

	if(fail_num ==0) begin 
		$display("test result is PASSED");
	end else begin 
		$display("test result is FAILED");
	end 
end
endtask
