module testbench();

/* Declare outputs */
wire valid,sample,cmp;
wire [7:0] result, value;


/* Declare inputs */
reg clk,go;

/* instantiating the module */
controller c(clk,go,valid,result, sample,value,cmp);

always begin
    #10;
    clk=~clk;
end

initial clk=0;
    reg [7:0] hold;
always @(posedge sample) begin
    hold = 8'b01000110;
end

assign cmp = ( hold >= value);

initial begin
    $monitor($time, "go=%b valid=%b result=%b sample=%b value=%b cmp=%b state=%b mask=%b", go,valid,result,sample,value,cmp,c.state,c.mask);
    #100; go=0;#100; go=1;
    #5000; go=0;#5000; go=1;
    #40; go=0;
    #5000;
    $stop;
end
endmodule 