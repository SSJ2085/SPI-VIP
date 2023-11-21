class slave_agt_config extends uvm_object;

	`uvm_object_utils(slave_agt_config)

	virtual spi_if vif;

	static int s_drv_data_count = 0;
	static int s_mon_data_count = 0;

	uvm_active_passive_enum is_active = UVM_ACTIVE;

	extern function new(string name = "slave_agt_config");

endclass




//------------------------------------ Constructor New ---------------------------------//

function slave_agt_config::new(string name = "slave_agt_config");
	super.new(name);
endfunction : new
