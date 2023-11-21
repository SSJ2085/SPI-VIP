class slave_agent extends uvm_agent;

	`uvm_component_utils(slave_agent)

	slave_monitor monh;
	slave_driver drvh;
	slave_sequencer seqrh;

	slave_agt_config cfg;

	extern function new(string name = "slave_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass




//------------------------------------ Constructor New ---------------------------------//

function slave_agent::new(string name = "slave_agent",uvm_component parent);
	super.new(name,parent);
endfunction : new





//------------------------------------ build phase ---------------------------------//

function void slave_agent::build_phase(uvm_phase phase);
	if(!uvm_config_db #(slave_agt_config)::get(this,"","slave_agt_config",cfg))
		`uvm_fatal(get_type_name(),"cannot get cfg from spi_s_agt.Have you set it?")

	monh = slave_monitor::type_id::create("monh",this);

	if(cfg.is_active == UVM_ACTIVE)
	begin
		drvh = slave_driver::type_id::create("drvh",this);
		seqrh = slave_sequencer::type_id::create("seqrh",this);
	end

	`uvm_info(get_type_name(),"This is build phase in SPI_S_AGENT",UVM_LOW)
	super.build_phase(phase);

endfunction : build_phase




//------------------------------------ Connect phase ---------------------------------//

function void slave_agent::connect_phase(uvm_phase phase);
	if(cfg.is_active == UVM_ACTIVE)
		drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction : connect_phase
