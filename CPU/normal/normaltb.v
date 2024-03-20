
module decoder3to8_test;
  reg [2:0] in;
  reg en;
  wire [7:0] out;
  integer i;
  decoder3to8 dec3to8 (
      en,
      in,
      out
  );
  initial begin
    #0 $display("time\ten\tin\tout");
    #0 en = 1;
    in = 0;
    for (i = 1; 1 < 8; i = i + 1) begin
      #1 in = i;
    end
    #1 en = 0;
    #1 en = 1;
    n = 0;
    #1 $finish;
  end
  initial begin
    $monitor("%1d\t%b\t%b\t%b", $time, en, in, out);
    $dumpfile("decoder3to8.vcd");
    $dumpvars;
  end
endmodule