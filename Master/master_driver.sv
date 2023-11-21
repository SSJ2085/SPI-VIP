class master_driver extends uvm_driver #(master_xtn);

	`uvm_component_utils(master_driver)

	virtual wb_if.MDRV_MP vif;

	master_agt_config cfg;

	extern function new(string name = "master_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(master_xtn xtnh);

endclass : master_driver




//-------------------------- Contructor New -----------------------------//

function master_driver::new(string name = "master_driver",uvm_component parent);
	super.new(name,parent);
endfunction : new





//-------------------------- Build phase -----------------------------//

function void master_driver::build_phase(uvm_phase phase);
	if(!uvm_config_db #(master_agt_config)::get(this,"","master_agt_config",cfg))
		`uvm_fatal(get_type_name(),"cannot get cfg from spi_m_agt.Have you set it?")
	`uvm_info(get_type_name(),"This is build_phase inside SPI_M_DRIVER",UVM_LOW)

	super.build_phase(phase);
endfunction : build_phase




//-------------------------- Connect Phase -----------------------------//

function void master_driver::connect_phase(uvm_phase phase);
	vif = cfg.vif;
endfunction : connect_phase





//-------------------------- Run Phase -----------------------------//

task master_driver::run_phase(uvm_phase phase);
	master_xtn xtnh;
	@(vif.mdrv_cb);
	vif.mdrv_cb.wb_rst_i<=1'b1;
	vif.mdrv_cb.wb_stb_i<=1'b0;
	vif.mdrv_cb.wb_cyc_i<=1'b0;
	@(vif.mdrv_cb);
	vif.mdrv_cb.wb_rst_i<=1'b0;

	xtnh = master_xtn::type_id::create("xtnh");
	forever
	begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
	end
endtask : run_phase

//-------------------------- sent to dut -----------------------------//

task master_driver::send_to_dut(master_xtn xtnh);
	`uvm_info(get_type_name(),$sformatf("printing from m_driver \n %s",xtnh.sprint()),UVM_LOW);

	begin
		@(vif.mdrv_cb);
		vif.mdrv_cb.wb_stb_i<=1'b1;
		vif.mdrv_cb.wb_cyc_i<=1'b1;
		vif.mdrv_cb.wb_adr_i<=xtnh.wb_adr_i;
		vif.mdrv_cb.wb_dat_i<=xtnh.wb_dat_i;
		vif.mdrv_cb.wb_we_i<=xtnh.wb_we_i;
		vif.mdrv_cb.wb_sel_i<=4'b1111;

		@(vif.mdrv_cb);
		while(!vif.mdrv_cb.wb_ack_o)
			@(vif.mdrv_cb);
		vif.mdrv_cb.wb_stb_i<=1'b0;
		vif.mdrv_cb.wb_cyc_i<=1'b0;
	end

endtask : send_to_dut

		

		


