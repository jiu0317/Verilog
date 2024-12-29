module test(output reg [2:0] count);
  
  initial begin
    count=0;
  end
  
  always begin
    #1
    $display("Count : %b", count);
    count = count + 1;
    if ($time == 8) $finish;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
