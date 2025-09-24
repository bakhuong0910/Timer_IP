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
	$display("====PAT NAME:TCMP_access=======");
	$display("reset value access");
	@(posedge sys_clk);
	sys_rst_n=0;
	@(posedge sys_clk);
	read_reg(TCMP0);
	check_value("TCMP0",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	read_reg(TCMP1);
	check_value("TCMP1",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	sys_rst_n=1;
	//R/W access value check 
	@(posedge sys_clk);
	$display("R/W access value check");
	tim_pstrb=4'b1111;
	tim_pwdata=32'h0000_0000;
	write_reg(TCMP0);
	@(posedge sys_clk);
	read_reg(TCMP0);
	check_value("TCMP0",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hffff_ffff;
	write_reg(TCMP0);
	@(posedge sys_clk);
	read_reg(TCMP0);
	check_value("TCMP0",32'hffffffff,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'h5555_5555;
	write_reg(TCMP0);
	@(posedge sys_clk);
	read_reg(TCMP0);
	check_value("TCMP0",32'h55555555,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hAAAA_AAAA;
	write_reg(TCMP0);
	@(posedge sys_clk);
	read_reg(TCMP0);
	check_value("TCMP0",32'hAAAAAAAA,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'h0000_0000;
	write_reg(TCMP1);
	@(posedge sys_clk);
	read_reg(TCMP1);
	check_value("TCMP1",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hffff_ffff;
	write_reg(TCMP1);
	@(posedge sys_clk);
	read_reg(TCMP1);
	check_value("TCMP1",32'hffffffff,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'h5555_5555;
	write_reg(TCMP1);
	@(posedge sys_clk);
	read_reg(TCMP1);
	check_value("TCMP1",32'h55555555,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hAAAA_AAAA;
	write_reg(TCMP1);
	@(posedge sys_clk);
	read_reg(TCMP1);
	check_value("TCMP1",32'hAAAAAAAA,tim_prdata);
	
	if(fail_num ==0) begin 
		$display("test result is PASSED");
	end else begin 
		$display("test result is FAILED");
	end 
end
endtask
