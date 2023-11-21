class master_monitor extends uvm_monitor;

	`uvm_component_utils(master_monitor)

	virtual wb_if.MMON_MP vif;
        master_xtn mon_data;

	master_agt_config cfg;

	uvm_analysis_port #(master_xtn) monitor_port;

	extern function new(string name = "master_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();

endclass 


//-------------------------- Contructor New -----------------------------//

function master_monitor::new(string name = "master_monitor",uvm_component parent);
	super.new(name,parent);
	monitor_port = new("monitor_port",this);
endfunction : new




//-------------------------- build phase -----------------------------//

function void master_monitor::build_phase(uvm_phase phase);
	if(!uvm_config_db #(master_agt_config)::get(this,"","master_agt_config",cfg))
		`uvm_fatal(get_type_name(),"cannot get cfg from spi_m_agt.Have you set it?")

	`uvm_info(get_type_name(),"This is build_phase inside SPI_M_MONITOR",UVM_LOW)

	super.build_phase(phase);
endfunction : build_phase





//-------------------------- Connect Phase -----------------------------//

function void master_monitor::connect_phase(uvm_phase phase);
	vif = cfg.vif;
endfunction : connect_phase

task master_monitor::run_phase(uvm_phase phase);

	mon_data = master_xtn::type_id::create("mon_data");

	forever
	begin
	collect_data();
	end
endtask


//-------------------------- Collect data -----------------------------//

task master_monitor::collect_data();

	@(vif.mmon_cb);
	while(!vif.mmon_cb.wb_ack_o)
		@(vif.mmon_cb);
	
	begin
	if(vif.mmon_cb.wb_adr_i==5'h0 && vif.mmon_cb.wb_we_i==1'b1)
		begin	
		mon_data.TX0=vif.mmon_cb.wb_dat_i;
		mon_data.wb_adr_i = vif.mmon_cb.wb_adr_i;
		mon_data.wb_we_i = vif.mmon_cb.wb_we_i;
		end
	else if(vif.mmon_cb.wb_adr_i==5'h4 && vif.mmon_cb.wb_we_i==1'b1)
		begin
		mon_data.TX1=vif.mmon_cb.wb_dat_i;
		mon_data.wb_adr_i = vif.mmon_cb.wb_adr_i;
		mon_data.wb_we_i = vif.mmon_cb.wb_we_i;
		end
	else if(vif.mmon_cb.wb_adr_i==5'h8 && vif.mmon_cb.wb_we_i==1'b1)
 		begin
		mon_data.TX2=vif.mmon_cb.wb_dat_i;
		mon_data.wb_adr_i = vif.mmon_cb.wb_adr_i;
		mon_data.wb_we_i = vif.mmon_cb.wb_we_i;
		end
	else if(vif.mmon_cb.wb_adr_i==5'hc && vif.mmon_cb.wb_we_i==1'b1)
		begin
		mon_data.TX3=vif.mmon_cb.wb_dat_i;
		mon_data.wb_adr_i = vif.mmon_cb.wb_adr_i;
		mon_data.wb_we_i = vif.mmon_cb.wb_we_i;
		end

	else if(vif.mmon_cb.wb_adr_i==5'h0 && vif.mmon_cb.wb_we_i==1'b0)
		begin
		mon_data.RX0=vif.mmon_cb.wb_dat_o;
		mon_data.wb_adr_i = vif.mmon_cb.wb_adr_i;
		mon_data.wb_we_i = vif.mmon_cb.wb_we_i;
		end
	else if(vif.mmon_cb.wb_adr_i==5'h4 && vif.mmon_cb.wb_we_i==1'b0)
		begin
		mon_data.RX1=vif.mmon_cb.wb_dat_o;
		mon_data.wb_adr_i = vif.mmon_cb.wb_adr_i;
		mon_data.wb_we_i = vif.mmon_cb.wb_we_i;
		end
	else if(vif.mmon_cb.wb_adr_i==5'h8 && vif.mmon_cb.wb_we_i==1'b0)
		begin
		mon_data.RX2=vif.mmon_cb.wb_dat_o;
		mon_data.wb_adr_i = vif.mmon_cb.wb_adr_i;
		mon_data.wb_we_i = vif.mmon_cb.wb_we_i;
		end
	else if(vif.mmon_cb.wb_adr_i==5'hc && vif.mmon_cb.wb_we_i==1'b0)
		begin
		mon_data.RX3=vif.mmon_cb.wb_dat_o;
		mon_data.wb_adr_i = vif.mmon_cb.wb_adr_i;
		mon_data.wb_we_i = vif.mmon_cb.wb_we_i;
		end

	else if(vif.mmon_cb.wb_adr_i==5'h10 && vif.mmon_cb.wb_we_i==1'b1)
		begin
		mon_data.CTRL=vif.mmon_cb.wb_dat_i;
		mon_data.wb_adr_i = vif.mmon_cb.wb_adr_i;
		mon_data.wb_we_i = vif.mmon_cb.wb_we_i;
		end
	else if(vif.mmon_cb.wb_adr_i==5'h14 && vif.mmon_cb.wb_we_i==1'b1)
		begin
		mon_data.DIVIDER=vif.mmon_cb.wb_dat_i;
		mon_data.wb_adr_i = vif.mmon_cb.wb_adr_i;
		mon_data.wb_we_i = vif.mmon_cb.wb_we_i;
		end
	else if(vif.mmon_cb.wb_adr_i==5'h18 && vif.mmon_cb.wb_we_i==1'b1)
		begin
		mon_data.SS=vif.mmon_cb.wb_dat_i;
		mon_data.wb_adr_i = vif.mmon_cb.wb_adr_i;
		mon_data.wb_we_i = vif.mmon_cb.wb_we_i;
		end
	end

	monitor_port.write(mon_data);
	@(vif.mmon_cb);
	`uvm_info(get_type_name(),$sformatf("printing from m_monitor \n %s",mon_data.sprint()),UVM_LOW);

endtask




