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
	$display("====PAT NAME:INTERRUPT_verify=======");
	//enable count test
	$display("enable count test");
	sys_rst_n=0;
	@(posedge sys_clk);
	sys_rst_n=1;
	@(posedge sys_clk);
	tim_pstrb=4'b1111;
	tim_pwdata=32'h0000_0000;
	write_reg(TDR0);
	write_reg(TDR1);
	tim_pwdata=32'h0000_00ff;
	write_reg(TCMP0);
	tim_pwdata=32'h0000_0000;
	write_reg(TCMP1);
	tim_pwdata=32'h0000_0001;	
	write_reg(TIER);
	tim_pwdata=32'h01;
	write_reg(TCR);
	repeat(256+3) @(posedge sys_clk);
	if(tim_int ==1) begin 
		$display("=====================");
		$display("PASS: interrupt is occured");
		$display("=====================");
	end else begin
		fail_num=1;
		$display("=====================");
		$display("FAIL: interrupt is not occured");
		$display("=====================");
	end
	read_reg(TISR);
	check_value(TISR,32'h0000_0001,tim_prdata);
	@(posedge sys_clk);
	sys_rst_n=0;
	@(posedge sys_clk);
	sys_rst_n=1;
	@(posedge sys_clk);
	$display("config anh assert interrtupt again");
	tim_pwdata=32'h0000_0000;
        write_reg(TDR0);
        write_reg(TDR1);
        tim_pwdata=32'h0000_00ff;
        write_reg(TCMP0);
        tim_pwdata=32'h0000_0000;
        write_reg(TCMP1);
        tim_pwdata=32'h0000_0001;
        write_reg(TIER);
        tim_pwdata=32'h01;
        write_reg(TCR);
        repeat(256+3) @(posedge sys_clk);
        if(tim_int ==1) begin 
                $display("=====================");
                $display("PASS: interrupt is occured");
                $display("=====================");
        end else begin
                fail_num=1;
                $display("=====================");
                $display("FAIL: interrupt is not occured");
                $display("=====================");
        end
	@(posedge sys_clk);	
	tim_pwdata=32'h01;
	write_reg(TISR);
	@(posedge sys_clk);
	read_reg(TISR);
	check_value("TISR",32'h00000000,tim_prdata);
	// disabled interrupt
	@(posedge sys_clk);
	$display("disabled interrupt");
	sys_rst_n=0;
	@(posedge sys_clk);
	sys_rst_n=1;
	@(posedge sys_clk);
	tim_pstrb=4'b1111;
	tim_pwdata=32'h0000_0000;
	write_reg(TDR0);
	write_reg(TDR1);
	@(posedge sys_clk);
	tim_pwdata=32'h05;
	write_reg(TCMP0);
	@(posedge sys_clk); 
	tim_pwdata=32'h0203;
	write_reg(TCR);
	@(posedge sys_clk);
	tim_pwdata=32'h00;
	write_reg(TIER);
	repeat(16) @(posedge sys_clk);
	if(tim_int !=1) begin 
		$display("=====================");
		$display("PASS: interrupt is occured");
		$display("=====================");
	end else begin
		fail_num=1;
		$display("=====================");
		$display("FAIL: interrupt is not occured");
		$display("=====================");
	end
	@(posedge sys_clk);
	$display("disabled interrupt");
	sys_rst_n=0;
	@(posedge sys_clk);
	sys_rst_n=1;
	@(posedge sys_clk);
	tim_pstrb=4'b1111;
	tim_pwdata=32'h0000_0000;
	write_reg(TDR0);
	write_reg(TDR1);
	@(posedge sys_clk);
	tim_pwdata=32'h05;
	write_reg(TCMP0);
	@(posedge sys_clk); 
	tim_pwdata=32'h0203;
	write_reg(TCR);
	@(posedge sys_clk);
	tim_pwdata=32'h01;
	write_reg(TIER);
	repeat(16) @(posedge sys_clk);
	tim_pwdata=32'h00;
	write_reg(TIER);
	@(posedge sys_clk);
	if(tim_int ==0 ) begin 
		$display("=====================");
		$display("PASS: interrupt is not  occured and int_st remain unchanged");
		$display("=====================");
	end else begin
		fail_num=1;
		$display("=====================");
		$display("FAIL: interrupt is not occured");
		$display("=====================");
	end
	








	
	if(fail_num ==0) begin 
		$display("test result is PASSED");
	end else begin 
		$display("test result is FAILED");
	end 
	end
endtask
