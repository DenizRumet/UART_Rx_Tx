module transmitter(Clk,Send,PDin,SCout,SDout);  //Tx
	input Clk;
	input Send;   
	input [7:0] PDin;							// Paralel data
	output SCout;
	output SDout;

	reg [7:0] SRreg;							// Shift register to store 8-bit parallel data
	reg Serial_out;								// Transmission condition

	always @(posedge Clk)
		begin
			if (Send)			
				begin
					Serial_out <= 1'b1;			// starting condition				
					SRreg [7:0] <= PDin [7:0];	// Storing data
				end
			else  								// Paralel to Serial transmission
				begin
					Serial_out <= SRreg[0];		// MSB first
					SRreg[6:0] <= SRreg[7:1];	// shifting
					SRreg[7] <= 1'b0;			// clear LSB
				end
		end
 
	assign SCout = Clk; 						
	assign SDout = Serial_out; 					//Transmitting to Serial data 
 
endmodule

