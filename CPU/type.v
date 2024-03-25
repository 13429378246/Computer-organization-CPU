
module type #(
    parameter R1 = 7'h33,
    parameter R2 = 7'h3b,
    parameter Il = 7'h03,
    parameter Ih = 7'h0f,
    parameter Ii = 7'h13,
    parameter Ics = 7'h73,
    parameter Ij = 7'h67,
    parameter Iiw = 7'h1b,
    parameter S = 7'h23,
    parameter SB = 7'h63,
    parameter U1 = 7'h17,
    parameter U2 = 7'h37,
    parameter UJ = 7'h6f
) (
    in,
    opcode,
    imm,
    func,
    rs2,
    rs1,
    rd

);
  input [31:0] in;
  output reg [31:0] imm;
  output reg [4:0] rs2, rs1, rd;
  output reg [11:0] func;
  output wire [6:0] opcode;
  assign opcode = in[6:0];
  always @(*) begin
    case (opcode)
      R1,R2: begin
        imm  <= 0;
        func <= {1'b0,in[14:12],1'b0,in[31:25]};
        rs2  <= in[24:20];
        rs1  <= in[19:15];
        rd   <= in[11:7];
      end
      Il,Ih,Ii,Ics,Ij,Iiw: begin
        imm  <= {{20{in[31]}}, in[31:20]};
        func <= {1'b0,in[14:12],8'b0};
        rs2  <= 0;
        rs1  <= in[19:15];
        rd   <= in[11:7];
      end
      S: begin
        imm  <= {{20{in[31]}}, in[31:25], in[11:7]};
        func <= {1'b0,in[14:12],8'b0};
        rs2  <= in[24:20];
        rs1  <= in[19:15];
        rd   <= 0;
      end
      SB: begin
        imm  <= {{20{in[31]}},in[31], in[7], in[30:25], in[11:8]};
        func <= {1'b0,in[14:12],8'b0};
        rs2  <= in[24:20];
        rs1  <= in[19:15];
        rd   <= 0;
      end
      U1,U2: begin
        imm  <= {in[31:12],12'b0};
        func <= 0;
        rs2  <= 0;
        rs1  <= 0;
        rd   <= in[11:7];
      end
      UJ: begin
        imm  <= {{12{in[31]}}, in[31], in[19:12], in[20], in[30:21]};
        func <= {1'b0,in[14:12],1'b0,in[31:25]};
        rs2  <= 0;
        rs1  <= 0;
        rd   <= in[11:7];
      end
      default: begin
      imm<=0;
      func<=0;
      rs2<=0;
      rs1<=0;
      rd<=0;
      end
      


    endcase
  end



endmodule
