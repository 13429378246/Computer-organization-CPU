module alu (
    x,
    y,
    op,
    out,
    z
);
  input [31:0] x, y;
  input [3:0] op;
  output [31:0] out;
  output z;
  wire [31:0] and_op = x & y;
  wire [31:0] or_op = x | y;
  wire [31:0] xor_op = x ^ y;
  wire [31:0] lui_op = {y[19:0], 12'h0};
  assign z = ~|out;

endmodule