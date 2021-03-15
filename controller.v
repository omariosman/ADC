module controller(input clk, input go, output valid, output [7:0] result, output sample, output [7:0] value, input cmp);

reg [1:0] state; 
reg [7:0] mask, result;

parameter wait_state=0, sample_state=1, conv_state=2, done_state=3;

always @(posedge clk) begin
    if (!go) state <= wait_state;
    else case (state) 
        wait_state: state <= sample_state;
        sample_state :
        begin 
            state <= conv_state; 
            mask <= 8'b10000000; 
            result <= 8'b0; 
        end
            conv_state :
        begin
            if (cmp) result <= result | mask;
            mask <= mask>>1;
            if (mask[0]) state <= done_state;
        end
            done_state :;
    endcase
    end
        assign sample = state==sample_state;
        assign value = result | mask; 
        assign valid = state==done_state; 
endmodule