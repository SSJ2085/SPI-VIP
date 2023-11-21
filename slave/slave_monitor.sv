class slave_monitor extends uvm_monitor;

	`uvm_component_utils(slave_monitor)

	virtual spi_if.SMON_MP vif;

	slave_agt_config cfg;

	uvm_analysis_port #(slave_xtn) monitor_port;

	int ctrl;
	slave_xtn data;

	extern function new(string name = "slave_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();

endclass
//------------------------------------ Constructor New ---------------------------------//

function slave_monitor::new(string name = "slave_monitor",uvm_component parent);
	super.new(name,parent);
	monitor_port = new("monitor_port",this);
endfunction 
//------------------------------------ build phase ---------------------------------//

function void slave_monitor::build_phase(uvm_phase phase);

	if(!uvm_config_db #(slave_agt_config)::get(this,"","slave_agt_config",cfg))
		`uvm_fatal(get_type_name(),"cannot get cfg from slave_agt_config.Have you set it?")
	`uvm_info(get_type_name(),"This is build phase in SPI_S_MONITOR",UVM_LOW)
	
	if(!uvm_config_db #(int)::get(this,"","int",ctrl))
                `uvm_fatal(get_type_name(),"cannot get ctrl in spi_s_monitor.Have you set it?")
	super.build_phase(phase);

endfunction : build_phase
//------------------------------------ Connect phase ---------------------------------//

function void slave_monitor::connect_phase(uvm_phase phase);
	vif = cfg.vif;
endfunction : connect_phase

//------------------------------------- run phase ---------------------------------//

task slave_monitor::run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever
		collect_data();
endtask : run_phase
//------------------------------------ Collect data ---------------------------------//

task slave_monitor::collect_data();
//	if(!uvm_config_db #(int)::get(this,"","int",ctrl))
//		`uvm_fatal(get_type_name(),"cannot get ctrl in spi_s_monitor.Have you set it?")

	data = slave_xtn::type_id::create("data");
	@(vif.smon_cb);
	@(vif.smon_cb);
	if(ctrl[9])    
	begin
		if(ctrl[11])
		begin
			for(int i=0;i<=ctrl[6:0]-1;i++)
			begin
				@(negedge vif.smon_cb.sclk_pad_o);
				begin
					data.miso[i] = vif.smon_cb.miso_pad_i;
					data.mosi[i] = vif.smon_cb.mosi_pad_o;
				end
			end
		end
		else
		begin
			for(int i=ctrl[6:0]-1;i>=0;i--)
			begin
				@(negedge vif.smon_cb.sclk_pad_o);
				begin
					data.miso[i] = vif.smon_cb.miso_pad_i;
					data.mosi[i] = vif.smon_cb.mosi_pad_o;
				end
			end
		end
	end

	else
	begin
		if(ctrl[11])
		begin
			for(int i=0;i<=ctrl[6:0]-1;i++)
			begin
				@(posedge vif.smon_cb.sclk_pad_o);
				begin
					data.miso[i] = vif.smon_cb.miso_pad_i;
					data.mosi[i] = vif.smon_cb.mosi_pad_o;
				end
			end
		end
		else
		begin
			for(int i=ctrl[6:0]-1;i>=0;i--)
			begin
				@(posedge vif.smon_cb.sclk_pad_o);
				begin
					data.miso[i] = vif.smon_cb.miso_pad_i;
					data.mosi[i] = vif.smon_cb.mosi_pad_o;
				end
			end
		end
	end
	`uvm_info(get_type_name(),$sformatf("printing from SPI_S_MONITOR \n %s",data.sprint()),UVM_LOW);
	monitor_port.write(data);

endtask	
