//1'b0,func3 ,1'b0,func7
module alu #(
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
    x,
    y,
    op,
    func,
    out,
    
);
  input [31:0] x, y;
  input [6:0] op;
  input [11:0] func;
  output reg [31:0] out;
  output [31:0] cst;
  wire CF, PF, ZF, SF, OF;
  assign CF  = ((~x) < y) ? 1 : 0;
  assign PF  = ~^out;
  assign ZF  = (out == 0 ? 1 : 0);
  assign SF  = out[31];
  assign OF  = (x[31] & y[31] & ~out[31]) | (~x[31] & ~y[31] & out[31]);
  assign cst = {27'b0, CF, PF, ZF, SF, OF};




  wire [31:0] d_add_sub;

  wire [31:0] d_shift;
  wire [31:0] d_slt;
  assign d_slt = $signed(x) < $signed(y) ? 1 : 0;
  wire [31:0] d_sltul;
  assign d_sltu = x < y ? 1 : 0;
  wire [31:0] d_xor = x ^ y;
  wire [31:0] d_or = x | y;
  wire [31:0] d_and = x & y;
  wire [31:0] d_lui = {y[31:20], x[19:0]};
  wire [31:0] zero = 0;
  adder32 myadder (
      x,
      y,
      ~func[5],
      d_add_sub
  );
  shift myshift (
      x,
      y[4:0],
      func[10],
      func[6],
      d_shift
  );

  always @(*) begin
    case (op)
      R1, R2: begin
        case (func)
          f_add: out <= d_add_sub;
          f_sub: out <= d_add_sub;
          f_sll: out <= d_shift;
          f_slt: out <= d_slt;
          f_sltu: out <= d_sltu;
          f_xor: out <= d_xor;
          f_srl: out <= d_shift;
          f_sra: out <= d_shift;
          f_or: out <= d_or;
          f_and: out <= d_and;
          default: out <= 0;


        endcase

      end
      Il, Ih, Ii, Ics, Ij, Iiw: begin
        case (func)

          default: out <= 0;
        endcase

      end
      S: begin
        case (func)

          default: out <= 0;
        endcase
      end
      SB: begin
        case (func)

          default: out <= 0;
        endcase
      end
      U1, U2: begin
        case (func)
          f_lui:   out <= d_lui;
          default: out <= 0;
        endcase

      end
      UJ: begin
        case (func)

          default: out <= 0;
        endcase
      end
      default: begin
        out <= 0;
      end



    endcase
  end


endmodule
