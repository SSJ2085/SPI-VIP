class slave_xtn extends uvm_sequence_item;

	`uvm_object_utils(slave_xtn)

	rand bit[127:0]miso;
	bit [127:0]mosi;

	extern function new(string name = "slave_xtn");
	extern function void do_print(uvm_printer printer);

endclass



//------------------------------------ Constructor New ---------------------------------//

function slave_xtn::new(string name = "slave_xtn");
	super.new(name);
endfunction




//------------------------------------ do print ---------------------------------//

function void slave_xtn::do_print(uvm_printer printer);
	super.do_print(printer);
   
    	//     	            string name	      bitstream value           size	   radix for printing
    	printer.print_field("miso",		this.miso,		128, 	   UVM_HEX	     );

    	printer.print_field("mosi",		this.mosi,		128, 	   UVM_HEX	     );

endfunction : do_print
