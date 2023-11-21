class master_agt_top extends uvm_env;

	`uvm_component_utils(master_agt_top)

	master_agent m_agnth[];

	spi_env_config env_cfg;

	extern function new(string name = "master_agt_top",uvm_component parent);
	extern function void build_phase(uvm_phase phase);

endclass





//-------------------------- Contructor New -----------------------------//

function master_agt_top::new(string name = "master_agt_top",uvm_component parent);
	super.new(name,parent);
endfunction : new





//-------------------------- Build Phase -----------------------------//

function void master_agt_top::build_phase(uvm_phase phase);
	if(!uvm_config_db #(spi_env_config)::get(this,"","spi_env_config",env_cfg))
		`uvm_fatal(get_type_name(),"cannot get cfg from env.Have you set it?")

	m_agnth = new[env_cfg.no_of_m_agents];

	foreach(m_agnth[i])
	begin
		m_agnth[i] = master_agent::type_id::create($sformatf("m_agnth[%0d]",i),this);
		
		uvm_config_db #(master_agt_config)::set(this,$sformatf("m_agnth[%0d]*",i),"master_agt_config",env_cfg.m_agt_cfg[i]);
	end
	`uvm_info(get_type_name(),"This is build_phase inside SPI_M_AGT_TOP",UVM_LOW)

	super.build_phase(phase);
endfunction : build_phase
