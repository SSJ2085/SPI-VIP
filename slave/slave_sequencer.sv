class slave_sequencer extends uvm_sequencer #(slave_xtn);

	`uvm_component_utils(slave_sequencer)

	extern function new(string name = "slave_sequencer",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass : slave_sequencer
//------------------------------------ Constructor New ---------------------------------//

function slave_sequencer::new(string name = "slave_sequencer",uvm_component parent);
	super.new(name,parent);
endfunction
//--------------------- Build Phase --------------------------//

function void slave_sequencer :: build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_type_name(),"This is build phase of SPI_S_SEQUENCER",UVM_LOW)
endfunction : build_phase
