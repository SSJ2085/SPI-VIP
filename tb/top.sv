module top();
	import spi_pkg::*;
	import uvm_pkg::*;

	bit clock;

	initial
	begin
		forever #10 clock = ~clock;
	end

	wb_if in0(clock);
	spi_if in1(clock);

	spi_top dut(.wb_clk_i(in0.wb_clk_i),
		    .wb_rst_i(in0.wb_rst_i),
		    .wb_adr_i(in0.wb_adr_i),
		    .wb_dat_i(in0.wb_dat_i),
		    .wb_dat_o(in0.wb_dat_o),
		    .wb_sel_i(in0.wb_sel_i),
		    .wb_we_i(in0.wb_we_i),
		    .wb_stb_i(in0.wb_stb_i),
		    .wb_cyc_i(in0.wb_cyc_i),
		    .wb_ack_o(in0.wb_ack_o),
		    .wb_err_o(in0.wb_err_o),
		    .wb_int_o(in0.wb_int_o),

		    .ss_pad_o(in1.ss_pad_o),
		    .sclk_pad_o(in1.sclk_pad_o),
		    .mosi_pad_o(in1.mosi_pad_o),
		    .miso_pad_i(in1.miso_pad_i));

	initial
	begin

		`ifdef VCS
			$fsdbDumpvars(0,top);
		`endif

		uvm_config_db #(virtual wb_if)::set(null,"*","vif0",in0);
		uvm_config_db #(virtual spi_if)::set(null,"*","vif1",in1);

		run_test();
	end

endmodule
