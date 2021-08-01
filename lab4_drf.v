module lab4_drf(TPDin, TClk, TSend, TPDout, TPDready, Sclk2,Sdata);

input [7:0] TPDin;
input TClk;
input TSend;

output [7:0] TPDout;
output TPDready;
output Sclk2;
output Sdata;

wire TSCout;
wire TSDout;

assign Sclk2 = TSCout;
assign Sdata = TSDout;

reciever RxDRF(TSCout,TSDout, TPDout, TPDready);

transmitter TxDRF(TClk, TSend , TPDin, TSCout, TSDout);

endmodule

