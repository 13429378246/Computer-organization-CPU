module typetb();

  // Define parameters for convenience


  // Instantiate the module under test
  
    // Define signals
  reg [31:0] in;
  wire [6:0] opcode;
  wire [31:0] imm;
  wire [11:0] func;
  wire [4:0] rs2, rs1, rd;
  wire [31:0] out,cst;
  reg clk;
  reg [31:0] ram [0:31];
  integer i;
  initial begin
    for(i=1;i<32;i=i+1)begin
    ram[i]={32{1'b1}}-i;
    
    end
    
    
  
  end
type dut (
    .in(in),
    .opcode(opcode),
    .imm(imm),
    .func(func),
    .rs2(rs2),
    .rs1(rs1),
    .rd(rd)
  );
  
  alu aludut(ram[rs1],ram[rs2],opcode,func,out,cst);

 always #5 clk = ~clk;
 



  // Initial block to apply inputs
  initial begin
    // Example input values
        in = 32'b0000000_00000_00001_000_11111_0110011;
    clk = 0;

    // Print outputs
    $display("Opcode: %b", opcode);
    $display("Immediate: %b", imm);
    $display("Function: %b", func);
    $display("RS2: %b", rs2);
    $display("RS1: %b", rs1);
    $display("RD: %b", rd);
    $display("RS1VAL: %b",ram[rs1] );
    $display("RS2VAL: %b", ram[rs2]);
    $display("OF: %b", cst[0]);
    $display("CF: %b", cst[4]);
    $display("OUTVAL: %b", out);
    #10 in=32'b0000000_01010_10011_000_10010_0110011;
    #10 in=32'b0100000_01010_10011_000_10010_0110011;
    #10 in=32'b0100000_01110_10011_000_10010_0110011;
    #1000; 
    $finish;
    

  end

endmodule
