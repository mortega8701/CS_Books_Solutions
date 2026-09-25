module controller
	(input logic ta, tb, p, r, 
	input logic clk, reset,
	output logic[1:0] la, lb);

	logic m;

	mode modm(.p(p), .r(r), .clk(clk), .reset(reset), .m(m));
	lights modl(.ta(ta), .tb(tb), .m(m), .clk(clk), .reset(reset), .la(la), .lb(lb));
endmodule
