// (c) Technion IIT, Department of Electrical Engineering 2021 
//-- Alex Grinshpun Apr 2017
//-- Dudy Nov 13 2017
// SystemVerilog version Alex Grinshpun May 2018
// coding convention dudy December 2018
// updaed Eyal Lev Feb 2021


module	test0	(	
					input	logic	clk,
					
					output	 logic signed 	[10:0]	result 
					
					
);



assign 	result = 0 ;   // note it must be 2^n 

endmodule
