module top (
    clk,
    reset,
    inst,
    pc,
    aludata,
    memaddress
);
  input clk, reset;
  output [31:0] inst, pc, aludata, memaddress;
  wire we;
  wire [31:0] a, d, spo;
  wire [31:0] cst;


  cpu mycpu (
      clk,
      reset,
      inst,
      pc,
      we,
      aluout,
      cst
  );
  instmem myinstmem (
      pc,
      inst
  );
  datamem mydatamem (
      aludata,
      memaddress,
      clk,
      we,
      spo
  );


endmodule
