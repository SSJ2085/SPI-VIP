class spi_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

	`uvm_component_utils(spi_virtual_sequencer)

	master_sequencer m_seqrh[];
	slave_sequencer s_seqrh[];

	spi_env_config env_cfg;

	extern function new(string name = "spi_virtual_sequencer",uvm_component parent);
	extern function void build_phase(uvm_phase phase);

endclass : spi_virtual_sequencer




//-------------------------------------- Constructor New -------------------------------------//

function spi_virtual_sequencer::new(string name = "spi_virtual_sequencer",uvm_component parent);
	super.new(name,parent);
endfunction : new




//-------------------------------------- build phase -------------------------------------//

function void spi_virtual_sequencer::build_phase(uvm_phase phase);
	if(!uvm_config_db #(spi_env_config)::get(this,"","spi_env_config",env_cfg))
		`uvm_fatal(get_type_name(),"cannot get cfg from env_config.Have you set it?")

	m_seqrh = new[env_cfg.no_of_m_agents];
	s_seqrh = new[env_cfg.no_of_s_agents];
	`uvm_info(get_type_name(),"This is build phase in SPI_VIRTUAL_SEQUENCER",UVM_LOW)

endfunction : build_phase
