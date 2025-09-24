parameter TCR=12'h000;
parameter TDR0=12'h004;
parameter TDR1=12'h008;
task run_test();
	begin 
	fail_num=0;
	$display("====PAT NAME: TCR_access====");
	//reset value check
	$display("reset value check");
	sys_rst_n=0;
	@(posedge sys_clk);
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TCR);
	check_value("TCR",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	sys_rst_n=1;
	//R/W access check 
	$display("R/W access check ");
	@(posedge sys_clk);
	tim_pstrb=4'b1111;
	tim_pwdata=32'h00000000;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TCR);
	check_value("TCR",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hffffffff;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TCR);
	check_value("TCR",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'h55555555;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TCR);
	check_value("TCR",32'h00000501,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hAAAAAAAA;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TCR);
	check_value("TCR",32'h00000501,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hA5A5_A5A5;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TCR);
	check_value(TCR,32'h0000_0501,tim_prdata);
	$display("checking prohibited value for div_val)");
	@(posedge sys_clk);
	sys_rst_n=0;
	@(posedge sys_clk);
	sys_rst_n=1;
	@(posedge sys_clk);
	tim_pwdata=32'h0000_0803;
	write_reg(TCR);
	@(posedge sys_clk);
	if(tim_pslverr==0) begin 
		$display("pslverr=0 is CORRECT, wdata is not prohibited access");
	end else begin 
		fail_num=1;
		$display("pslverr=1 is FAIL, wdata is prohibited access<======");
	end
	@(posedge sys_clk);
	read_reg(TCR);
	check_value("TCR",32'h00000803,tim_prdata);
	@(posedge sys_clk);
	sys_rst_n=0;
	@(posedge sys_clk);
	sys_rst_n=1;
	@(posedge sys_clk);
	tim_pwdata=32'h0000_0903;
	write_reg(TCR);
	if(tim_pslverr==1) begin 
		$display("pslverr=1 is CORRECT, wdata is prohibited access");
	end else begin 
		fail_num=1;
		$display("pslverr=0 is FAIL, wdata is not prohibited access <======");
	end  
	@(posedge sys_clk);
	read_reg(TCR);
	check_value("TCR",32'h00000100,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'h0000_0703;
	write_reg(TCR);
	if(tim_pslverr==0) begin 
		$display("pslverr=0 is CORRECT, wdata is not prohibited access");
	end else begin 
		fail_num=1;
		$display("pslverr=1 is FAIL, wdata is prohibited access <======");
	end
	@(posedge sys_clk);
	read_reg(TCR);
	check_value("TCR",32'h00000703,tim_prdata);
	//Check timer_en 
	$display("check timer_en changes from H to L");
	@(posedge sys_clk);
	tim_pwdata=32'h00000001;
	write_reg(TCR);
	@(posedge sys_clk);
	tim_pwdata=32'h00000000;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TDR0);
	check_value("TDR0",32'h00000000,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'h00000001;
	write_reg(TCR);
	@(posedge sys_clk);
	tim_pwdata=32'h00000000;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TDR1);
	check_value("TDR1",32'h00000000,tim_prdata);
	//R/W access check 
	tim_pwdata=32'hffff_f3ff;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TCR);
	check_value("TCR",32'h0000_0703,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'h0000_0003;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TCR);
	check_value("TCR",32'h0000_0703,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'hffff_ffff;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TCR);
	check_value(TCR,32'h0000_0703,tim_prdata);
	@(posedge sys_clk);
	tim_pwdata=32'h0000_0000;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TCR);
	check_value(TCR,32'h0000_0703,tim_prdata);
	//R/W with pstrb[1]=0 to mask div_en
	@(posedge sys_clk);
	tim_pstrb=4'b0000;
	tim_pwdata=32'h0000_0011;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TCR);
	check_value(TCR,32'h0000_0703,tim_prdata);// TCR keep the old value 
	@(posedge sys_clk);
	sys_rst_n=0;
	@(posedge sys_clk);
	sys_rst_n=1;
	@(posedge sys_clk);
	tim_pstrb=4'b0010;
	tim_pwdata=32'h0000_0001;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TCR);
	check_value(TCR,32'h0000_0000,tim_prdata);
	@(posedge sys_clk);
	tim_pstrb=4'b1000;
	tim_pwdata=32'h0000_0002;
	write_reg(TCR);
	@(posedge sys_clk);
	read_reg(TCR);
	check_value(TCR,32'h0000_0000,tim_prdata);
	




	@(posedge sys_clk);
	if(fail_num !=0) begin 
		$display("test result is FAILED");
	end else begin 
		$display("test result is PASSED");
	end

	end
endtask	
