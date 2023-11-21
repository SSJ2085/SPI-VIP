class master_agt_config extends uvm_object;

	`uvm_object_utils(master_agt_config)

	virtual wb_if vif;

	static int m_drv_data_count = 0;
	static int m_mon_data_count = 0;

	uvm_active_passive_enum is_active = UVM_ACTIVE;

	extern function new(string name = "master_agt_config");

endclass : master_agt_config





//-------------------------- Contructor New -----------------------------//

function master_agt_config::new(string name = "master_agt_config");
	super.new(name);
endfunction : new
