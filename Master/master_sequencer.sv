class master_sequencer extends uvm_sequencer #(master_xtn);

	`uvm_component_utils(master_sequencer)

	extern function new(string name = "master_sequencer",uvm_component parent);
	extern function void build_phase(uvm_phase phase);

endclass : master_sequencer




//-------------------------- Contructor New -----------------------------//

function master_sequencer::new(string name = "master_sequencer",uvm_component parent);
	super.new(name,parent);
endfunction : new	




//-----------------------------  Build Phase -----------------------------//
function void master_sequencer :: build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_type_name(),"This is build_phase inside SPI_M_SEQUENCER",UVM_LOW)
endfunction : build_phase
