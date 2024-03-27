module cpu(clk,reset,inst,mem,pc,we,aludata,cst,memaddress);
input clk,reset;
input [31:0] inst,mem;
output we;
output [31:0] pc,aludata,cst,memaddress;


   wire [4:0] regswa, regsra;
   wire [31:0] regswd;
   wire regswe, regsre;
  wire [31:0] regsspo;

 
  wire [31:0] imm;
  wire [4:0] tprs2, tprs1, tprd;
  wire [4:0] rs2, rs1, rd;
  wire [31:0] rs2x,rs1x,rdx;
  wire [11:0] func;
  wire [6:0] opcode;

  wire [31:0] cst;

  wire [31:0] x,y;

wire [1:0] pc_tp;//pc 0:+4  1:jal [rd]=pc+imm+4   2:jalr [rd]=[rs1]+imm+4
wire wregrd;
wire rregrs1;
wire rregrs2;
wire shiften;// shift
wire signexen;//sign bit extension
wire wmem;//write to memory
wire rmem;
wire isj;//jal jalr

assign rs1=(rregrs1==1)?tprs1:0;
assign rs2=(rregrs2==1)?tprs2:0;
assign rd=(rregrd==1)?tprd:0;
assign x=(wmem==1?mem:rs1x);
assign y=(wmem==1?mem:rs2x);
assign nextpc=pc_tp==0 ? pc+4:(pc_tp==1 ? pc+imm+4:x+imm+4);

type mytp(
    inst,
    opcode,
    imm,
    func,
    tprs2,
    tprs1,
    tprd
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
    rs1x,  //read_data
    clk,
    reset
);

regsmem rs2mem(
    rs2,  //address
    32'b0,  //data
    1'b0,  //write_en
    rs2x,  //read_data
    clk,
    reset
);

regsmem rdmem(
    rd,  //address
    aludata,  //data
    rregrd,  //write_en
    rdx,  //read_data
    clk,
    reset
);

ulogic myulogic(op,func,pc_tp,wregrd,rregrs1,rregrs2,shiften,signexen,wmem,rmem,isj

);

register32(nextpc,1'b1,reset,clk,pc);

assign we=(wmem==1)?1:0;

assign memaddress=(wmem||rmem)?tprd:0;



endmodule