class slave_seqs extends uvm_sequence #(slave_xtn);

	`uvm_object_utils(slave_seqs)

	extern function new(string name = "slave_seqs");

endclass
//------------------------------------ Constructor New ---------------------------------//

function slave_seqs::new(string name = "slave_seqs");
	super.new(name);
endfunction
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
//Test Case 1

class slave_tc1 extends slave_seqs;
	
	`uvm_object_utils(slave_tc1);

	extern function new(string name = "slave_tc1");
	extern task body();

endclass
//------------------------------------ Constructor New ---------------------------------//

function slave_tc1::new(string name = "slave_tc1");
	super.new(name);
endfunction
//------------------------------------ task body ---------------------------------//
task slave_tc1::body();
begin
	req = slave_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize());
	`uvm_info(get_type_name(),$sformatf("Printing from SEQUENCE \n %s",req.sprint()),UVM_LOW);
	finish_item(req);
end
endtask
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
//Test Case 2

class slave_tc2 extends slave_seqs;
	
	`uvm_object_utils(slave_tc2);

	extern function new(string name = "slave_tc2");
	extern task body();

endclass
//------------------------------------ Constructor New ---------------------------------//

function slave_tc2::new(string name = "slave_tc2");
	super.new(name);
endfunction
//------------------------------------ task body ---------------------------------//

task slave_tc2::body();
begin
	req = slave_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize());
	`uvm_info(get_type_name(),$sformatf("Printing from SEQUENCE \n %s",req.sprint()),UVM_LOW);
	finish_item(req);
end
endtask
//***************************************************************************************************************************
//**************************************************************************************************************************-
//Test Case 3

class slave_tc3 extends slave_seqs;
	
	`uvm_object_utils(slave_tc3);

	extern function new(string name = "slave_tc3");
	extern task body();

endclass


//------------------------------------ Constructor New ---------------------------------//

function slave_tc3::new(string name = "slave_tc3");
	super.new(name);
endfunction 
//------------------------------------ task body ---------------------------------//

task slave_tc3::body();
begin
	req = slave_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize());
	`uvm_info(get_type_name(),$sformatf("Printing from SEQUENCE \n %s",req.sprint()),UVM_LOW);
	finish_item(req);
end
endtask
//-----------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------
//Test Case 4
class slave_tc4 extends slave_seqs;
	
	`uvm_object_utils(slave_tc4);

	extern function new(string name = "slave_tc4");
	extern task body();

endclass
//------------------------------------ Constructor New ---------------------------------//

function slave_tc4::new(string name = "slave_tc4");
	super.new(name);
endfunction
//------------------------------------ task body ---------------------------------//
task slave_tc4::body();
begin
	req = slave_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize());
	`uvm_info(get_type_name(),$sformatf("Printing from SEQUENCE \n %s",req.sprint()),UVM_LOW);
	finish_item(req);
end
endtask
