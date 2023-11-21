class slave_agt_top extends uvm_env;

	`uvm_component_utils(slave_agt_top)

	slave_agent s_agnth[];

	spi_env_config env_cfg;

	extern function new(string name = "slave_agt_top",uvm_component parent);
	extern function void build_phase(uvm_phase phase);

endclass
//------------------------------------ Constructor New ---------------------------------//

function slave_agt_top::new(string name = "slave_agt_top",uvm_component parent);
	super.new(name,parent);
endfunction : new




//------------------------------------ Build Phase ---------------------------------//

function void slave_agt_top::build_phase(uvm_phase phase);
	if(!uvm_config_db #(spi_env_config)::get(this,"","spi_env_config",env_cfg))
		`uvm_fatal(get_type_name(),"cannot get cfg from spi_env.Have you set it?")

	s_agnth = new[env_cfg.no_of_s_agents];

	foreach(s_agnth[i])
	begin
		s_agnth[i] = slave_agent::type_id::create($sformatf("s_agnth[%0d]",i),this);
		
		uvm_config_db #(slave_agt_config)::set(this,$sformatf("s_agnth[%0d]*",i),"slave_agt_config",env_cfg.s_agt_cfg[i]);
	end
	`uvm_info(get_type_name(),"This is build phase in SPI_S_AGT_TOP",UVM_LOW)
	super.build_phase(phase);

endfunction : build_phase
