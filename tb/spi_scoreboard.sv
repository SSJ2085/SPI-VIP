class spi_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(spi_scoreboard)

	uvm_tlm_analysis_fifo #(master_xtn) master_fifo;
	uvm_tlm_analysis_fifo #(slave_xtn) slave_fifo;

	spi_env_config env_cfg;

	master_xtn mxtn;
	slave_xtn sxtn;

	bit [127:0] tx,rx;
	bit [6:0] char_len;

	master_xtn m_cov;

	// COVERAGE
	covergroup spi_cov;
		option.per_instance = 1;
	CHAR_LENGTH : coverpoint m_cov.CTRL[6:0] {bins low = {[0:31]};
						 bins mid1 = {[32:63]};
						 bins mid2 = {[64:95]};
						 bins high = {[96:127]};}

	GO_BUSY : coverpoint m_cov.CTRL[8] {bins gb = {1};}

	TXRX_NEG : coverpoint m_cov.CTRL[10:9] {bins tx = {2'b10};
					       bins rx = {2'b01};}

	LSB : coverpoint m_cov.CTRL[11] {bins msb = {0};
					bins lsb = {1};}

	IE : coverpoint m_cov.CTRL[12] {bins ie1 = {1};
					bins ie2 = {0};}

	ASS : coverpoint m_cov.CTRL[13] {bins ass = {0};
					bins ass1 = {1};}

	endgroup 

	extern function new(string name = "spi_scoreboard",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern function void check_phase(uvm_phase phase);
	extern function void report_phase(uvm_phase phase);

endclass : spi_scoreboard
//------------------------------------ Constructor New ---------------------------------//

function spi_scoreboard::new(string name = "spi_scoreboard",uvm_component parent);
	super.new(name,parent);
	spi_cov = new;
endfunction : new
//------------------------------------ build phase ---------------------------------//

function void spi_scoreboard::build_phase(uvm_phase phase);

	if(!uvm_config_db #(spi_env_config)::get(this,"","spi_env_config",env_cfg))
		`uvm_fatal(get_type_name(),"cannot get cfg from env_config.Have you set it?")

	master_fifo = new("master_fifo",this);
	slave_fifo = new("slave_fifo",this);

	`uvm_info(get_type_name(),"This is build phase in SPI_SCOREBOARD",UVM_LOW)
	super.build_phase(phase);
endfunction : build_phase
//------------------------------------ run phase ---------------------------------//
task spi_scoreboard::run_phase(uvm_phase phase);
	begin
		master_fifo.get(mxtn);

		slave_fifo.get(sxtn);
			char_len = mxtn.CTRL[6:0];
			if(char_len == 0)
				char_len = 128;

		if(char_len <= 32)
			master_fifo.get(mxtn);
		else if(char_len <= 64)
		begin
			master_fifo.get(mxtn);
			master_fifo.get(mxtn);
		end
		else if(char_len <= 96)
		begin
			master_fifo.get(mxtn);
			master_fifo.get(mxtn);
			master_fifo.get(mxtn);
		end
		else
		begin
			master_fifo.get(mxtn);
			master_fifo.get(mxtn);
			master_fifo.get(mxtn);
			master_fifo.get(mxtn);
		end

		m_cov = mxtn;
		spi_cov.sample();
	end
endtask : run_phase
//------------------------------------ Check phase ---------------------------------//

function void spi_scoreboard::check_phase(uvm_phase phase);
	tx = {mxtn.TX3,mxtn.TX2,mxtn.TX1,mxtn.TX0};
	rx = {mxtn.RX3,mxtn.RX2,mxtn.RX1,mxtn.RX0};

	for(int i=0;i<char_len;i++)
	begin
		if(rx[i] == sxtn.miso[i])
			$display("DATA MATCHED SUCCESSFULLY ------------> rx = %d  miso = %d",rx[i],sxtn.miso[i]);
		else
			$display("DATA MISMATCHED !!!!!!!!!!!!!!!!!!!!!!! %d",i);
	end
	for(int i=0;i<char_len;i++)
	begin
		if(tx[i] == sxtn.mosi[i])
			$display("DATA MATCHED SUCCESSFULLY ------------> tx = %d  mosi = %d",tx[i],sxtn.mosi[i]);
		else
			$display("DATA MISMATCHED !!!!!!!!!!!!!!!!!!!!!!! %d",i);
	end
endfunction : check_phase



//------------------------------------ Report phase ---------------------------------//

function void spi_scoreboard::report_phase(uvm_phase phase);
	$display("\n===============================================================");
	$display("===============================================================");
	$display("\n********************* * FINAL RESULT *************************");
	$display("\nCHAR_LEN = \t%0d",char_len);
	$display("\nMOSI     = \t%0h",sxtn.mosi);
	$display("\nMISO     = \t%0h",sxtn.miso);
	$display("\nTX_REG   = \t%0h",tx);
	$display("\nRX_REG   = \t%0h",rx);
	$display("\n===============================================================");

endfunction : report_phase	
