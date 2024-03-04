/*regs_heap*/
module regs_heap (
    adr_rx,
    adr_ry,
    adr_w,
    data_w,
    write,
    reset,
    clk,
    data_x,
    data_y
);
  input [4:0] adr_rx, adr_ry, adr_w;
  input [31:0] data_w;
  input write, reset, clk;
  output [31:0] data_x, data_y;
  reg [31:0] regs[0:31];
  integer i;
  assign data_x = (write == 1) ? 0 : regs[adr_rx];
  assign data_y = (write == 1) ? 0 : regs[adr_ry];

  always @(posedge clk or negedge reset) begin
    if (!reset) begin

      for (i = 0; i < 32; i = i + 1) begin
        regs[i] <= 0;
      end

    end else if (write) begin
      regs[adr_w] <= data_w;
    end
  end
endmodule