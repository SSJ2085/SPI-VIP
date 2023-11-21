class master_agent extends uvm_agent;

	`uvm_component_utils(master_agent)

	master_monitor monh;
	master_driver drvh;
	master_sequencer m_seqrh;

	master_agt_config cfg;

	extern function new(string name = "master_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass




//--------------------------  Contructor New   -----------------------------//

function master_agent::new(string name = "master_agent",uvm_component parent);
	super.new(name,parent);
endfunction : new

//-------------------------- build phase -----------------------------//

function void master_agent::build_phase(uvm_phase phase);
	if(!uvm_config_db #(master_agt_config)::get(this,"","master_agt_config",cfg))
		`uvm_fatal(get_type_name(),"cannot get() cfg from spi_m_agt_config.Have you set it?")
	
	monh = master_monitor::type_id::create("monh",this);
	if(cfg.is_active == UVM_ACTIVE)
	begin
		drvh = master_driver::type_id::create("drvh",this);
		m_seqrh = master_sequencer::type_id::create("m_seqrh",this);
	end

	`uvm_info(get_type_name(),"This is build_phase inside SPI_M_AGENT",UVM_LOW)

	super.build_phase(phase);
endfunction : build_phase





//-------------------------- Connect Phase -----------------------------//

function void master_agent::connect_phase(uvm_phase phase);
	if(cfg.is_active == UVM_ACTIVE)
		drvh.seq_item_port.connect(m_seqrh.seq_item_export);
endfunction : connect_phase	
