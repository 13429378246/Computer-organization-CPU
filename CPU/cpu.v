module cpu(clk,reset,inst,pc,we,aludata,cst,memaddress);
input clk,reset;
input [31:0] inst;
output we;
output [31:0] pc,aludata,cst,memaddress;


   wire [4:0] regswa, regsra;
   wire [31:0] regswd;
   wire regswe, regsre;
  wire [31:0] regsspo;

 
  wire [31:0] imm;
  wire [4:0] rs2, rs1, rd;
  wire [11:0] func;
  wire [6:0] opcode;

  wire [31:0] cst;

  wire [31:0] x,y;

type mytp(
    inst,
    opcode,
    imm,
    func,
    rs2,
    rs1,
    rd

);  

alu myalu(
    x,
    y,
    opcode,
    func,
    aludata,
    cst
);
regsmem rs1mem(
    rs1,  //address
    32'b0,  //data
    1'b0,  //write_en
    x,  //read_data
    clk,
    reset
);

regsmem rs2mem(
    rs2,  //address
    32'b0,  //data
    1'b0,  //write_en
    x,  //read_data
    clk,
    reset
);

assign we=cst[31];

assign memaddress=(we==1)?rd:0;



endmodule