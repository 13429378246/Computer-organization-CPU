module regsmem (
    a,  //address
    d,  //data
    we,  //write_en
    spo,  //read_data
    clk,
    reset
);
  input [4:0] a;
  input [31:0] d;
  input clk, we, reset;
  output reg [31:0] spo;
  reg [31:0] mem_regs[0:31];
  integer i;
  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      for (i = 0; i < 32; i = i + 1) mem_regs[i] <= 0;
    end else if (we) begin
      if (a != 0) begin
        mem_regs[a] <= d;
      end
      spo <= 0;
    end else begin
      spo <= mem_regs[a];
    end
  end
endmodule
