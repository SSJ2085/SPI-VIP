class master_rd_seqs extends uvm_sequence #(master_xtn);

	//Factory Registration
	`uvm_object_utils(master_rd_seqs)

	int ctrl1;

	extern function new(string name = "master_rd_seqs");
	extern task body();

endclass : master_rd_seqs



//-------------------------- Contructor New -----------------------------//

function master_rd_seqs::new(string name = "master_rd_seqs");
	super.new(name);
endfunction : new




//-------------------------- Task Body -----------------------------//

task master_rd_seqs :: body();
	if(!uvm_config_db #(int) :: get(null,get_full_name(),"int",ctrl1))
		`uvm_fatal(get_type_name(),"Cannot get CTRL reg data into spi_m_read_seqs.Have you set it?")

endtask : body






//---------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------

class master_rd_seqs_1 extends master_rd_seqs;

	//Factory Registration
	`uvm_object_utils(master_rd_seqs_1)

	extern function new(string name = "master_rd_seqs_1");
	extern task body();

endclass

//-------------------------- Contructor New -----------------------------//

function master_rd_seqs_1 :: new(string name = "master_rd_seqs_1");
	super.new(name);
endfunction : new

//-------------------------- task body -----------------------------//

task master_rd_seqs_1 :: body();
	super.body();

	//Collecting in RX register
	req = master_xtn::type_id::create("req");

	start_item(req);
	assert(req.randomize() with {wb_adr_i == 5'h0; wb_we_i == 1'b0;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with {wb_adr_i == 5'h4; wb_we_i == 1'b0;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with {wb_adr_i == 5'h8; wb_we_i == 1'b0;});
	finish_item(req);
	
	start_item(req);
	assert(req.randomize() with {wb_adr_i == 5'hc; wb_we_i == 1'b0;});
	finish_item(req);

endtask

//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------

class master_rd_seqs_2 extends master_rd_seqs;

	//Factory Registration
	`uvm_object_utils(master_rd_seqs_2)

	extern function new(string name = "master_rd_seqs_2");
	extern task body();

endclass
//-------------------------- Contructor New -----------------------------//

function master_rd_seqs_2 :: new(string name = "master_rd_seqs_2");
	super.new(name);
endfunction : new




//-------------------------- task body -----------------------------//

task master_rd_seqs_2 :: body();
	super.body();

	//collecting in RX register
	req = master_xtn::type_id::create("req");
	
	if(ctrl1[6:0]<32)
	begin
		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h0;wb_we_i == 1'b0;});
		finish_item(req);
	end

	else if(ctrl1[6:0] < 64)
	begin

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h0;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h4;wb_we_i == 1'b0;});
		finish_item(req);
	end

	else if(ctrl1[6:0] < 96)
	begin
		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h0;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h4;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h8;wb_we_i == 1'b0;});
		finish_item(req);
	end

	else
	begin
		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h0;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h4;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h8;wb_we_i == 1'b0;});
		finish_item(req);
	
		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'hc; wb_we_i == 1'b0;});
		finish_item(req);
	end
endtask




//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------

class master_rd_seqs_3 extends master_rd_seqs;

	//Factory Registration
	`uvm_object_utils(master_rd_seqs_3)

	extern function new(string name = "master_rd_seqs_3");
	extern task body();

endclass
//-------------------------- Contructor New -----------------------------//

function master_rd_seqs_3 :: new(string name = "master_rd_seqs_3");
	super.new(name);
endfunction : new
//-------------------------- task body -----------------------------//

task master_rd_seqs_3 :: body();
	super.body();

	//collecting in RX register
	req = master_xtn::type_id::create("req");

	if(ctrl1[6:0]<32)
	begin
		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h0;wb_we_i == 1'b0;});
		finish_item(req);
	end

	else if(ctrl1[6:0] < 64)
	begin

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h0;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h4;wb_we_i == 1'b0;});
		finish_item(req);
	end

	else if(ctrl1[6:0] < 96)
	begin
		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h0;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h4;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h8;wb_we_i == 1'b0;});
		finish_item(req);
	end

	else
	begin
		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h0;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h4;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h8;wb_we_i == 1'b0;});
		finish_item(req);
	
		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'hc; wb_we_i == 1'b0;});
		finish_item(req);
	end

endtask




//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------

class master_rd_seqs_4 extends master_rd_seqs;

	//Factory Registration
	`uvm_object_utils(master_rd_seqs_4)

	extern function new(string name = "master_rd_seqs_4");
	extern task body();

endclass




//-------------------------- Contructor New -----------------------------//

function master_rd_seqs_4 :: new(string name = "master_rd_seqs_4");
	super.new(name);
endfunction : new




//-------------------------- task body -----------------------------//

task master_rd_seqs_4 :: body();
	super.body();

	//collecting in RX register
	req = master_xtn::type_id::create("req");

	if(ctrl1[6:0]<32)
	begin
		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h0;wb_we_i == 1'b0;});
		finish_item(req);
	end

	else if(ctrl1[6:0] < 64)
	begin

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h0;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h4;wb_we_i == 1'b0;});
		finish_item(req);
	end

	else if(ctrl1[6:0] < 96)
	begin
		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h0;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h4;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h8;wb_we_i == 1'b0;});
		finish_item(req);
	end

	else
	begin
		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h0;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h4;wb_we_i == 1'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'h8;wb_we_i == 1'b0;});
		finish_item(req);
	
		start_item(req);
		assert(req.randomize() with {wb_adr_i == 5'hc; wb_we_i == 1'b0;});
		finish_item(req);
	end

endtask
