module reciever(SCin,SDin,PDout,PDready);  //Rx
	input SCin; 	
	input SDin; 		// Serial data input
	output [7:0] PDout; // Parallel output
	output PDready;     

	reg [7:0] SRreg; // Shift Register
	reg [3:0] Counter;	
	reg ctrl;		


	always @(posedge SCin)
	begin
		if ( SDin && (Counter [3:0] == 4'b0) ) 	// Data control part
			ctrl <= 1'b1;									
		else
			if (Counter[3:0] == 4'd7)
			ctrl <= 1'b0;
			else
			ctrl <= ctrl;	
	end


	always @(posedge SCin)								  // Shift Register
	begin
		if (ctrl)									
			begin
				SRreg [6:0] <= SRreg[7:1];						
				SRreg [7] <= SDin;							
			end
		else
			SRreg [7:0] <= SRreg [7:0];				
	end

	always @(posedge SCin)
	begin
		if (ctrl)
			Counter [3:0] <= Counter [3:0] + 4'b1;				
									
		else
			Counter [3:0] <= 4'b0;				
	end


assign PDready = (Counter [3:0] == 4'd8) ? 1'b1 : 1'b0;   
assign PDout [7:0] = SRreg [7:0]; // (PDready==1) ? SRreg [7:0] : 8'b0;
 
 
endmodule
