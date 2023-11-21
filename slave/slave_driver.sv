class slave_driver extends uvm_driver #(slave_xtn);

	`uvm_component_utils(slave_driver)

	virtual spi_if.SDRV_MP vif;

	slave_agt_config cfg;

	int ctrl;

	extern function new(string name = "slave_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(slave_xtn xtn);

endclass




//------------------------------------ Constructor New ---------------------------------//

function slave_driver::new(string name = "slave_driver",uvm_component parent);
	super.new(name,parent);
endfunction : new




//------------------------------------ build phase ---------------------------------//

function void slave_driver::build_phase(uvm_phase phase);

	if(!uvm_config_db #(slave_agt_config)::get(this,"","slave_agt_config",cfg))
		`uvm_fatal(get_type_name(),"cannot get cfg from spi_s_agt_config.Have you set it?")
	`uvm_info(get_type_name(),"This is build phase in SPI_S_DRIVER",UVM_LOW)
	super.build_phase(phase);

endfunction : build_phase

//------------------------------------ Connect phase ---------------------------------//

function void slave_driver::connect_phase(uvm_phase phase);
	vif = cfg.vif;
endfunction : connect_phase
//------------------------------------ run phase ---------------------------------//

task slave_driver::run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever
	begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
	end
endtask : run_phase





//------------------------------------ task drive ---------------------------------//

task slave_driver::send_to_dut(slave_xtn xtn);
	if(!uvm_config_db #(int)::get(this,"","int",ctrl))
		`uvm_fatal(get_type_name(),"cannot get ctrl in spi_s_driver.Have you set it?")

	if(ctrl[9])   //posedge
	begin
		if(ctrl[11])
		begin
			for(int i = 0;i<=ctrl[6:0]-1;i++)
			begin
				@(posedge vif.sdrv_cb.sclk_pad_o);
				vif.sdrv_cb.miso_pad_i <= xtn.miso[i];
			end
		end
	
		else
		begin
			for(int i=ctrl[6:0]-1;i>=0;i--)
			begin
				@(posedge vif.sdrv_cb.sclk_pad_o);
				vif.sdrv_cb.miso_pad_i <= xtn.miso[i];
			end
		end
		@(negedge vif.sdrv_cb.sclk_pad_o);
	end

	else
	begin
		if(ctrl[11])
		begin
			for(int i = 0;i<=ctrl[6:0]-1;i++)
			begin
				@(negedge vif.sdrv_cb.sclk_pad_o);
				vif.sdrv_cb.miso_pad_i <= xtn.miso[i];
			end
		end

		else
		begin
			for(int i=ctrl[6:0]-1;i>=0;i--)
			begin
				@(negedge vif.sdrv_cb.sclk_pad_o);
				vif.sdrv_cb.miso_pad_i <= xtn.miso[i];
			end
		end
		@(posedge vif.sdrv_cb.sclk_pad_o);
	end

	`uvm_info(get_type_name(),$sformatf("printing from SPI_S_DRIVER \n %s",xtn.sprint()),UVM_LOW);
	repeat(2)
	@(vif.sdrv_cb);

endtask


