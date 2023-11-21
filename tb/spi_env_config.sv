class spi_env_config extends uvm_object;

	`uvm_object_utils(spi_env_config)

	bit has_magent = 1;
	bit has_sagent = 1;

	int no_of_s_agents = 1;
	int no_of_m_agents = 1;

	master_agt_config m_agt_cfg[];
	slave_agt_config s_agt_cfg[];

	bit has_scoreboard = 1;
	bit has_virtual_sequencer = 1;

	extern function new(string name = "spi_env_config");

endclass : spi_env_config



//------------------------------------ Constructor New ---------------------------------//

function spi_env_config::new(string name = "spi_env_config");
	super.new(name);
endfunction
