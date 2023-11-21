class spi_env extends uvm_env;

	`uvm_component_utils(spi_env)

	master_agt_top magt_top;
	slave_agt_top sagt_top;

	spi_scoreboard sbh;

	spi_virtual_sequencer v_seqrh;

	spi_env_config env_cfg;

	extern function new(string name = "spi_env",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass : spi_env
//------------------------------------ Constructor New ---------------------------------//

function spi_env::new(string name = "spi_env",uvm_component parent);
	super.new(name,parent);
endfunction : new
//------------------------------------ build phase ---------------------------------//

function void spi_env::build_phase(uvm_phase phase);
	if(!uvm_config_db #(spi_env_config)::get(this,"","spi_env_config",env_cfg))
		`uvm_fatal(get_type_name(),"cannot get cfg from env_config.Have you set it?")

	if(env_cfg.has_magent)
	begin
		magt_top = master_agt_top::type_id::create("magt_top",this);
	end

	if(env_cfg.has_sagent)
	begin
		sagt_top = slave_agt_top::type_id::create("sagt_top",this);
	end

	if(env_cfg.has_scoreboard)
	begin
		sbh = spi_scoreboard::type_id::create("sbh",this);
	end

	if(env_cfg.has_virtual_sequencer)
	begin
		v_seqrh = spi_virtual_sequencer::type_id::create("v_seqrh",this);
	end
	`uvm_info(get_type_name(),"This is build phase in SPI_ENV",UVM_LOW)
	super.build_phase(phase);

endfunction : build_phase
//------------------------------------ Connect phase ---------------------------------//

function void spi_env::connect_phase(uvm_phase phase);
	if(env_cfg.has_virtual_sequencer)
	begin
		if(env_cfg.has_magent)
		begin
			for(int i = 0;i<env_cfg.no_of_m_agents;i++)
				v_seqrh.m_seqrh[i] = magt_top.m_agnth[i].m_seqrh;
		end

		if(env_cfg.has_sagent)
		begin
			for(int i = 0;i<env_cfg.no_of_s_agents;i++)
				v_seqrh.s_seqrh[i] = sagt_top.s_agnth[i].seqrh;
		end

	end

	if(env_cfg.has_scoreboard)
	begin
		if(env_cfg.has_magent)
		begin
			foreach(env_cfg.m_agt_cfg[i])
			begin
				magt_top.m_agnth[i].monh.monitor_port.connect(sbh.master_fifo.analysis_export);
			end
		end

		if(env_cfg.has_sagent)
		begin
			foreach(env_cfg.s_agt_cfg[i])
			begin
				sagt_top.s_agnth[i].monh.monitor_port.connect(sbh.slave_fifo.analysis_export);
			end
		end
	end
endfunction : connect_phase
