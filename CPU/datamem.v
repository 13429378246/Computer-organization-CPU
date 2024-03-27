module datamem (
    a,
    d,
    clk,
    we,
    spo
);
  input [31:0] a, d;
  input clk, we;
  output [31:0] spo;
  wire [7:0] data_spo;
  assign spo = {{24{data_spo[7]}}, data_spo};

  data_ram data_mem (
      .a  (a[7:0]),
      .d  (d[7:0]),
      .clk(clk),
      .we (we),
      .spo(data_spo)
  );

endmodule
