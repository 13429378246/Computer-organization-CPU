module instmem (
    pc,
    inst
);
  input [31:0] pc;
  output [31:0] inst;
  wire [31:0] inst_rom[0:31];
  assign inst_rom[5'h00] = 32'h0000_0000;
  assign inst_rom[5'h01] = 32'h0000_0000;
  assign inst_rom[5'h02] = 32'h0000_0000;

endmodule
