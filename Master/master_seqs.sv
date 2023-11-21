class master_seqs extends uvm_sequence #(master_xtn);

	`uvm_object_utils(master_seqs)

	extern function new(string name = "master_seqs");
endclass : master_seqs



//-------------------------- Contructor New -----------------------------//

function master_seqs::new(string name = "master_seqs");
	super.new(name);
endfunction : new



//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------
//Extending Base seq for tc1

class master_tc1 extends master_seqs;

	`uvm_object_utils(master_tc1);

	int ctrl;

	extern function new(string name = "master_tc1");
	extern task body();

endclass




//-------------------------- Contructor New -----------------------------//

function master_tc1::new(string name = "master_tc1");
	super.new(name);
endfunction




//-------------------------- task body -----------------------------//

task master_tc1::body();
	if(!uvm_config_db #(int)::get(null,get_full_name(),"int",ctrl))
		`uvm_fatal(get_type_name(),"cannot get ctrl from config data base.Have you set it?")

	req = master_xtn::type_id::create("req");
	
	//Tx0
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h0;wb_we_i == 1;wb_dat_i == 'h11111111;});
	finish_item(req);

	//Tx1
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h4;wb_we_i == 1;wb_dat_i == 'h22222222;});
	finish_item(req);

	//Tx2
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h8;wb_we_i == 1;wb_dat_i == 'h33333333;});
	finish_item(req);

	//Tx3
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'hc;wb_we_i == 1;wb_dat_i == 'h44444444;});
	finish_item(req);

	//DIVIDER
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h14;wb_we_i == 1;wb_dat_i[15:0] == 16'h1111 ;wb_dat_i[31:16] == 16'b0;});
	finish_item(req);

	//SS
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h18;wb_we_i == 1;wb_dat_i[31:8] == 24'b0; wb_dat_i[7:0] == 8'h11;});
	finish_item(req);

	//CTRL
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h10;wb_we_i == 1;wb_dat_i == ctrl;});
	finish_item(req);

endtask



//---------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------
//Extending Base seq for tc2

class master_tc2 extends master_seqs;

	`uvm_object_utils(master_tc2);

	int ctrl;

	extern function new(string name = "master_tc2");
	extern task body();

endclass



//-------------------------- Contructor New -----------------------------//

function master_tc2::new(string name = "master_tc2");
	super.new(name);
endfunction




//-------------------------- task body -----------------------------//

task master_tc2::body();
	if(!uvm_config_db #(int)::get(null,get_full_name(),"int",ctrl))
		`uvm_fatal(get_type_name(),"cannot get ctrl from config data base.Have you set it?")

	req = master_xtn::type_id::create("req");	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h0;wb_we_i == 1;wb_dat_i == 'h55555555;});
	finish_item(req);

	req = master_xtn::type_id::create("req");	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h4;wb_we_i == 1;wb_dat_i == 'h66666666;});
	finish_item(req);

	req = master_xtn::type_id::create("req");	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h8;wb_we_i == 1;wb_dat_i == 'h77777777;});
	finish_item(req);

	req = master_xtn::type_id::create("req");	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'hc;wb_we_i == 1;wb_dat_i == 'h88888888;});
	finish_item(req);

	req = master_xtn::type_id::create("req");	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h14;wb_we_i == 1;wb_dat_i[15:0] == 16'h2222 ;wb_dat_i[31:16] == 16'b0;});
	finish_item(req);

	req = master_xtn::type_id::create("req");	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h18;wb_we_i == 1; wb_dat_i[31:8] == 24'b0; wb_dat_i[7:0] == 8'h22;});
	finish_item(req);

	req = master_xtn::type_id::create("req");	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h10;wb_we_i == 1;wb_dat_i == ctrl;});
	finish_item(req);

endtask




//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------
//Extending Base seq for tc3

class master_tc3 extends master_seqs;

	`uvm_object_utils(master_tc3);

	int ctrl;

	extern function new(string name = "master_tc3");
	extern task body();

endclass



//-------------------------- Contructor New -----------------------------//

function master_tc3::new(string name = "master_tc3");
	super.new(name);
endfunction



//-------------------------- task body -----------------------------//

task master_tc3::body();
	if(!uvm_config_db #(int)::get(null,get_full_name(),"int",ctrl))
		`uvm_fatal(get_type_name(),"cannot get ctrl from config data base.Have you set it?")

	req = master_xtn::type_id::create("req");
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h0;wb_we_i == 1;wb_dat_i == 'h99999999;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h4;wb_we_i == 1;wb_dat_i == 'haaaaaaaa;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h8;wb_we_i == 1;wb_dat_i == 'hbbbbbbbb;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'hc;wb_we_i == 1;wb_dat_i == 'hcccccccc;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h14;wb_we_i == 1;wb_dat_i[15:0] == 16'h3333 ;wb_dat_i[31:16] == 16'b0;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h18;wb_we_i == 1;wb_dat_i[31:8] == 24'b0;wb_dat_i[7:0] == 8'h33;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h10;wb_we_i == 1;wb_dat_i == ctrl;});
	finish_item(req);

endtask




//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------
//Extending Base seq for tc4

class master_tc4 extends master_seqs;

	`uvm_object_utils(master_tc4);

	int ctrl;

	extern function new(string name = "master_tc4");
	extern task body();

endclass



//-------------------------- Contructor New -----------------------------//

function master_tc4::new(string name = "master_tc4");
	super.new(name);
endfunction



//-------------------------- task body -----------------------------//

task master_tc4::body();
	if(!uvm_config_db #(int)::get(null,get_full_name(),"int",ctrl))
		`uvm_fatal(get_type_name(),"cannot get ctrl from config data base.Have you set it?")

	req = master_xtn::type_id::create("req");
	
	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h0;wb_we_i == 1;wb_dat_i == 'hdddddddd;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h4;wb_we_i == 1;wb_dat_i == 'heeeeeeee;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h8;wb_we_i == 1;wb_dat_i == 'hffffffff;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'hc;wb_we_i == 1;wb_dat_i == 'h00000000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h14;wb_we_i == 1;wb_dat_i[15:0] == 16'h4444 ;wb_dat_i[31:16] == 16'b0;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h18;wb_we_i == 1;wb_dat_i[31:8] == 24'b0;wb_dat_i[7:0] == 8'h44;});
	finish_item(req);

	start_item(req);
	assert(req.randomize with {wb_adr_i == 5'h10;wb_we_i == 1;wb_dat_i == ctrl;});
	finish_item(req);

endtask


