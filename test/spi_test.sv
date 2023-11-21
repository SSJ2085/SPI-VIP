class spi_test extends uvm_test;

	`uvm_component_utils(spi_test)

	spi_env envh;

	master_agt_config m_agt_cfg[];
	slave_agt_config s_agt_cfg[];

	spi_env_config env_cfg;

	bit has_magent = 1;
	bit has_sagent = 1;

	int no_of_m_agents = 1;
	int no_of_s_agents = 1;

	bit has_scoreboard = 1;
	bit has_virtual_sequencer = 1;

	extern function new(string name = "spi_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void config_spi();
	extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : spi_test
//-------------------------------------- Constructor New -------------------------------------//
function spi_test::new(string name = "spi_test",uvm_component parent);
	super.new(name,parent);
endfunction : new
//-------------------------------------- build phase -------------------------------------//
function void spi_test::build_phase(uvm_phase phase);
	env_cfg = spi_env_config::type_id::create("env_cfg");

	if(has_magent)
		env_cfg.m_agt_cfg = new[no_of_m_agents];

	if(has_sagent)
		env_cfg.s_agt_cfg = new[no_of_s_agents];

	config_spi();

	uvm_config_db #(spi_env_config)::set(this,"*","spi_env_config",env_cfg);

	super.build_phase(phase);

	envh = spi_env::type_id::create("envh",this);

endfunction : build_phase
//-------------------------------------- config spi -------------------------------------//
function void spi_test::config_spi();

	if(has_magent)
	begin
		m_agt_cfg = new[no_of_m_agents];
		foreach(m_agt_cfg[i])
		begin
			m_agt_cfg[i] = master_agt_config::type_id::create($sformatf("m_agt_cfg[%0d]",i));

			if(!uvm_config_db #(virtual wb_if)::get(this,"","vif0",m_agt_cfg[i].vif))
				`uvm_fatal(get_type_name(),"cannot get cfg from spi_if.Have you set it?")

			m_agt_cfg[i].is_active = UVM_ACTIVE;

			env_cfg.m_agt_cfg[i] = m_agt_cfg[i];
		end
	end

	if(has_sagent)
	begin
		s_agt_cfg = new[no_of_s_agents];
		foreach(s_agt_cfg[i])
		begin
			s_agt_cfg[i] = slave_agt_config::type_id::create($sformatf("s_agt_cfg[%0d]",i));

			if(!uvm_config_db #(virtual spi_if)::get(this,"","vif1",s_agt_cfg[i].vif))
				`uvm_fatal(get_type_name(),"cannot get cfg from spi_if.Have you set it?")

			s_agt_cfg[i].is_active = UVM_ACTIVE;

			env_cfg.s_agt_cfg[i] = s_agt_cfg[i];
		end
	end

	env_cfg.no_of_m_agents = no_of_m_agents;
	env_cfg.no_of_s_agents = no_of_s_agents;

	env_cfg.has_magent = has_magent;
	env_cfg.has_sagent = has_sagent;

	env_cfg.has_scoreboard = has_scoreboard;
	env_cfg.has_virtual_sequencer = has_virtual_sequencer;

endfunction : config_spi

//-------------------------------------- elaboration phase -------------------------------------//

function void spi_test::end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction : end_of_elaboration_phase

//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//creating test class 1

class spi_test1 extends spi_test;

	`uvm_component_utils(spi_test1)

	spi_vseq1 tc1_vseqh;

	int CTRL;

	extern function new(string name = "spi_test1",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass
//-------------------------------------- Constructor New -------------------------------------//

function spi_test1::new(string name = "spi_test1",uvm_component parent);
	super.new(name,parent);
endfunction
//-------------------------------------- build phase -------------------------------------//

function void spi_test1::build_phase(uvm_phase phase);
	CTRL[6:0] = 7'd127;
	CTRL[7] = 0;
	CTRL[8] = 1;
	CTRL[9] = 1;
	CTRL[10] = 0;
	CTRL[11] = 0;
	CTRL[13:12] = 2'b11;
	CTRL[31:14] = 0;

	uvm_config_db #(int)::set(this,"*","int",CTRL);

	super.build_phase(phase);
endfunction
//-------------------------------------- run phase -------------------------------------//

task spi_test1::run_phase(uvm_phase phase);
	phase.raise_objection(this);
		
	tc1_vseqh = spi_vseq1::type_id::create("tc1_vseqh");
		
	tc1_vseqh.start(envh.v_seqrh);

	phase.drop_objection(this);
endtask
//-----------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------
//creating test class 2

class spi_test2 extends spi_test;

	`uvm_component_utils(spi_test2)

	spi_vseq2 tc2_vseqh;

	int CTRL;

	extern function new(string name = "spi_test2",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass
//-------------------------------------- Constructor New -------------------------------------//

function spi_test2::new(string name = "spi_test2",uvm_component parent);
	super.new(name,parent);
endfunction
//-------------------------------------- build phase -------------------------------------//

function void spi_test2::build_phase(uvm_phase phase);
	CTRL [6:0]=7'd77;  //CHAR LENGHT==10
	CTRL [7]=0;	     //RESERVED BIT  
	CTRL [8]=1;	     // GO BUSY
	CTRL [10:9]=2'b01;  //TX_NEG ==1 AND RX_NEG==0  
	CTRL [13:11]=3'd7; // ASS=1 IE=1 MSB/LSB =1
	CTRL [31:14]=0;    //RESERVED BIT

	uvm_config_db #(int)::set(this,"*","int",CTRL);

	super.build_phase(phase);
endfunction

task spi_test2::run_phase(uvm_phase phase);
	phase.raise_objection(this);
		
	tc2_vseqh = spi_vseq2::type_id::create("tc2_vseqh");
		
	tc2_vseqh.start(envh.v_seqrh);

	phase.drop_objection(this);
endtask
//----------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------
//creating test class 3

class spi_test3 extends spi_test;

	`uvm_component_utils(spi_test3)

	spi_vseq3 tc3_vseqh;

	int CTRL;

	extern function new(string name = "spi_test3",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-------------------------------------- Constructor New -------------------------------------//

function spi_test3::new(string name = "spi_test3",uvm_component parent);
	super.new(name,parent);
endfunction
//-------------------------------------- build phase -------------------------------------//

function void spi_test3::build_phase(uvm_phase phase);
	CTRL[6:0] = 7'd47;
	CTRL[7] = 0;
	CTRL[8] = 1;
	CTRL[9] = 1;
	CTRL[10] = 0;
	CTRL[11] = 1;
	CTRL[13:12] = 2'b01;
	CTRL[31:14] = 0;

	uvm_config_db #(int)::set(this,"*","int",CTRL);

	super.build_phase(phase);
endfunction

//-------------------------------------- run phase -------------------------------------//

task spi_test3::run_phase(uvm_phase phase);
	phase.raise_objection(this);
		
	tc3_vseqh = spi_vseq3::type_id::create("tc3_vseqh");
		
	tc3_vseqh.start(envh.v_seqrh);
	
	phase.drop_objection(this);
endtask
//----------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------
//creating test class 3

class spi_test4 extends spi_test;

	`uvm_component_utils(spi_test4)

	spi_vseq4 tc4_vseqh;

	int CTRL;

	extern function new(string name = "spi_test4",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass
//-------------------------------------- Constructor New -------------------------------------//

function spi_test4::new(string name = "spi_test4",uvm_component parent);
	super.new(name,parent);
endfunction
//-------------------------------------- build phase -------------------------------------//

function void spi_test4::build_phase(uvm_phase phase);
	CTRL[6:0] = 7'd20;
	CTRL[7] = 0;
	CTRL[8] = 1;
	CTRL[9] = 1;
	CTRL[10] = 0;
	CTRL[11] = 1;
	CTRL[13:12] = 2'b10;
	CTRL[31:14] = 0;

	uvm_config_db #(int)::set(this,"*","int",CTRL);

	super.build_phase(phase);
endfunction

//-------------------------------------- run phase -------------------------------------//

task spi_test4::run_phase(uvm_phase phase);
	phase.raise_objection(this);
		
	tc4_vseqh = spi_vseq4::type_id::create("tc4_vseqh");
		
	tc4_vseqh.start(envh.v_seqrh);
	
	phase.drop_objection(this);
endtask
