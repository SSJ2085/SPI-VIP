class spi_vbase_sequence extends uvm_sequence #(uvm_sequence_item);

	`uvm_object_utils(spi_vbase_sequence)

	master_sequencer m_seqrh[];
	slave_sequencer s_seqrh[];

	spi_virtual_sequencer v_seqrh;

	spi_env_config env_cfg;	

	extern function new(string name = "spi_vbase_sequence");
	extern task body();

endclass : spi_vbase_sequence





//-------------------------------------- Constructor New -------------------------------------//

function spi_vbase_sequence::new(string name = "spi_vbase_sequence");
	super.new(name);
endfunction : new




//-------------------------------------- task body -------------------------------------//

task spi_vbase_sequence::body();
	if(!uvm_config_db #(spi_env_config)::get(null,get_full_name(),"spi_env_config",env_cfg))
		`uvm_fatal(get_type_name(),"cannot get cfg from env.Have you set it?")
	
	m_seqrh = new[env_cfg.no_of_m_agents];
	s_seqrh = new[env_cfg.no_of_s_agents];

	assert($cast(v_seqrh,m_sequencer))
	else
	begin
		`uvm_fatal(get_type_name(),"Error in $cast of virtual sequencer")
	end

	foreach(m_seqrh[i])
	begin
		m_seqrh[i] = v_seqrh.m_seqrh[i];
	end

	foreach(s_seqrh[i])
	begin
		s_seqrh[i] = v_seqrh.s_seqrh[i];
	end

endtask

/***************************************************************************************************/

class spi_vseq1 extends spi_vbase_sequence;

	`uvm_object_utils(spi_vseq1)

	master_tc1 mxtn;
	slave_tc1 sxtn;

	//declaring handle for m_read_seqs_1
	master_rd_seqs_1 m_rd_xtn;

	extern function new(string name = "spi_vseq1");
	extern task body();

endclass
//-------------------------------------- Constructor New -------------------------------------//

function spi_vseq1::new(string name = "spi_vseq1");
	super.new(name);
endfunction
//-------------------------------------- task body -------------------------------------//

task spi_vseq1::body();
	super.body();

	if(env_cfg.has_magent)
		mxtn = master_tc1::type_id::create("mxtn");

			mxtn.start(m_seqrh[0]);

	if(env_cfg.has_sagent)
		sxtn = slave_tc1::type_id::create("sxtn");

			sxtn.start(s_seqrh[0]);

	if(env_cfg.has_magent)
		m_rd_xtn = master_rd_seqs_1::type_id::create("m_rd_xtn");
			
			m_rd_xtn.start(m_seqrh[0]);

endtask
//------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------
//Extended class from base seq as tc2

class spi_vseq2 extends spi_vbase_sequence;

	`uvm_object_utils(spi_vseq2)

	master_tc2 mxtn;
	slave_tc2 sxtn;

	//declaring handle for m_read_seqs_2
	master_rd_seqs_2 m_rd_xtn2;

	extern function new(string name = "spi_vseq2");
	extern task body();

endclass
//-------------------------------------- Constructor New -------------------------------------//

function spi_vseq2::new(string name = "spi_vseq2");
	super.new(name);
endfunction
//-------------------------------------- task body -------------------------------------//

task spi_vseq2::body();
	super.body();

	if(env_cfg.has_magent)
		mxtn = master_tc2::type_id::create("mxtn");

			mxtn.start(m_seqrh[0]);

	if(env_cfg.has_sagent)
		sxtn = slave_tc2::type_id::create("sxtn");

			sxtn.start(s_seqrh[0]);

	if(env_cfg.has_magent)
		m_rd_xtn2 = master_rd_seqs_2::type_id::create("m_rd_xtn2");

			m_rd_xtn2.start(m_seqrh[0]);

endtask
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//Extended class from base seq as tc3

class spi_vseq3 extends spi_vbase_sequence;

	`uvm_object_utils(spi_vseq3)

	master_tc3 mxtn;
	slave_tc3 sxtn;

	master_rd_seqs_3 m_rd_xtn3;

	extern function new(string name = "spi_vseq3");
	extern task body();

endclass
//-------------------------------------- Constructor New -------------------------------------//

function spi_vseq3::new(string name = "spi_vseq3");
	super.new(name);
endfunction

//-------------------------------------- task body -------------------------------------//

task spi_vseq3::body();
	super.body();

	if(env_cfg.has_magent)
		mxtn = master_tc3::type_id::create("mxtn");

			mxtn.start(m_seqrh[0]);

	if(env_cfg.has_sagent)
		sxtn = slave_tc3::type_id::create("sxtn");

			sxtn.start(s_seqrh[0]);

	if(env_cfg.has_magent);
		m_rd_xtn3 = master_rd_seqs_3::type_id::create("m_rd_xtn3");

			m_rd_xtn3.start(m_seqrh[0]);
endtask

/*************************************************************************************************************/

class spi_vseq4 extends spi_vbase_sequence;

	`uvm_object_utils(spi_vseq4)

	master_tc4 mxtn;
	slave_tc4 sxtn;

	master_rd_seqs_4 m_rd_xtn4;

	extern function new(string name = "spi_vseq4");
	extern task body();

endclass
//-------------------------------------- Constructor New -------------------------------------//

function spi_vseq4::new(string name = "spi_vseq4");
	super.new(name);
endfunction
//-------------------------------------- task body -------------------------------------//

task spi_vseq4::body();
	super.body();

	if(env_cfg.has_magent)
		mxtn = master_tc4::type_id::create("mxtn");

			mxtn.start(m_seqrh[0]);

	if(env_cfg.has_sagent)
		sxtn = slave_tc4::type_id::create("sxtn");

			sxtn.start(s_seqrh[0]);

	if(env_cfg.has_magent);
		m_rd_xtn4 = master_rd_seqs_4::type_id::create("m_rd_xtn4");

			m_rd_xtn4.start(m_seqrh[0]);

endtask

