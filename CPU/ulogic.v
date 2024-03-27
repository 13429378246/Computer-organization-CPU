module ulogic #(
    parameter R1  = 7'h33,
    parameter R2  = 7'h3b,
    parameter Il  = 7'h03,
    parameter Ih  = 7'h0f,
    parameter Ii  = 7'h13,
    parameter Ics = 7'h73,
    parameter Ij  = 7'h67,
    parameter Iiw = 7'h1b,
    parameter S   = 7'h23,
    parameter SB  = 7'h63,
    parameter U1  = 7'h17,
    parameter U2  = 7'h37,
    parameter UJ  = 7'h6f,

    parameter f_add  = 12'h000,
    parameter f_sub  = 12'h020,
    parameter f_sll  = 12'h100,
    parameter f_slt  = 12'h200,
    parameter f_sltu = 12'h300,
    parameter f_xor  = 12'h400,
    parameter f_srl  = 12'h500,
    parameter f_sra  = 12'h520,
    parameter f_or   = 12'h600,
    parameter f_and  = 12'h700,

    parameter f_lui = 12'h000





) (
    op,
    func,
    pc_tp,
    wregrd,
    rregrs1,
    rregrs2,
    shiften,
    signexen,
    wmem,
    rmem,
    isj
);

  input [6:0] op;
  input [11:0] func;
  output [1:0] pc_tp;  //pc 0:+4  1:jal [rd]=pc+imm+4   2:jalr [rd]=[rs1]+imm+4
  output wregrd;
  output rregrs1;
  output rregrs2;
  output shiften;  // shift
  output signexen;  //sign bit extension
  output wmem;  //write to memory
  output rmem;
  output isj;  //jal jalr



  wire add;
  wire sub;
  wire sll;
  wire slt;
  wire sltu;
  wire myxor;
  wire srl;
  wire sra;
  wire myor;
  wire myand;
  wire lui;

  assign add   = (op == R1 && func == f_add) ? 1 : 0;
  assign sub   = (op == R1 && func == f_sub) ? 1 : 0;
  assign sll   = (op == R1 && func == f_sll) ? 1 : 0;
  assign slt   = (op == R1 && func == f_slt) ? 1 : 0;
  assign sltu  = (op == R1 && func == f_sltu) ? 1 : 0;
  assign myxor = (op == R1 && func == f_xor) ? 1 : 0;
  assign srl   = (op == R1 && func == f_srl) ? 1 : 0;
  assign sra   = (op == R1 && func == f_sra) ? 1 : 0;
  assign myor  = (op == R1 && func == f_or) ? 1 : 0;
  assign myand = (op == R1 && func == f_and) ? 1 : 0;
  assign lui   = (op == U2 && func == f_lui) ? 1 : 0;







endmodule
