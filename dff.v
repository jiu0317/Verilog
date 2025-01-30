`timescale 1ns/1ps

module d_ff_test(
    input clk,
    input sync_reset,
    input async_reset,
    input async_reset_n,
    input i_value,

    output o_value_sync_reset,
    output o_value_async_reset,
    output o_value_async_reset_n,
    output o_value_mixed_reset,
    output o_value_no_reset,
);

    reg  r_ff_sync_reset	;
    reg  r_ff_async_reset	;
    reg  r_ff_async_reset_n	;
    reg  r_ff_mixed_reset	;
    reg  r_ff_no_reset		;


    //1. sync reset dff
    always @(posedge clk) begin
        if (sync_reset) begin
            r_ff_async_reset<=1'b0;
        end else begin
            r_ff_sync_reset<=i_value;
        end
    end

    //2. async reset dff
    always @(posedge clk or posedge async_reset) begin
        if (async_reset) begin
            r_async_reset<=1'b0;
        end else begin
            r_async_reset<=i_value;
        end
    end

    //3. async reset n dff
    always @(posedge clk or negedge async_reset_n) begin
        if (!async_reset_n) begin
            r_async_reset_n<=1'b0;
        end else begin
            r_async_reset_n<=i_value;
        end
    end

    //4. mixed reset dff
    always @(posedge clk or async_reset) begin
        if (async_reset) begin
            r_ff_mixed_reset<=1'b0;
        end else if (sync_reset) begin
            r_ff_mixed_reset<=1'b0;
        end else begin
            r_ff_mixed_reset<=i_value;
        end
    end

    //5. dff
    always @(clk) begin
        r_ff_no_reset<=i_value;
    end

    assign  o_value_sync_reset		= r_ff_sync_reset	;
    assign  o_value_async_reset		= r_ff_async_reset	;
    assign  o_value_async_reset_n	= r_ff_async_reset_n;
    assign  o_value_mixed_reset		= r_ff_mixed_reset	;
    assign  o_value_no_reset  		= r_ff_no_reset	;

    endmodule
