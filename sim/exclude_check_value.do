coverage exclude -scope /test_bench/check_value -src run_test.v -code b -line 178 -comment {check value is just a checking task, not functional of DUT} 
coverage exclude -scope /test_bench/check_value -src run_test.v -code b -line 182 -comment {this line never happen because expected_value always equal actual value} 
coverage exclude -scope /test_bench/check_value -src run_test.v -code c -line 178 -comment {check value is just a checking task, not functional of DUT} 
coverage exclude -scope /test_bench/u_top/u_apb_slave -src ../rtl/apb_slave.v -code s -line 55 -comment {this case never happen because of design specification} 
coverage exclude -scope /test_bench/u_top/u_apb_slave -src ../rtl/apb_slave.v -code b -line 55 -comment {this case never happen because of design specification} 
coverage exclude -scope /test_bench/u_top/u_cnt_ctrl -src ../rtl/cnt_ctrl.v -code s -line 55 -comment {this line never happen} 
coverage exclude -scope /test_bench/u_top/u_cnt_ctrl -src ../rtl/cnt_ctrl.v -code b -line 54 -comment {this case never happen because pslverr will be occured if div_val have default value} 
