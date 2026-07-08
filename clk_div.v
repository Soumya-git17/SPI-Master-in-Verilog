module clk_div #(parameter CLK_DIV = 50) (
    input clk, rst, clk_en,
    output reg sclk, tick
);

reg [$clog2(CLK_DIV)-1:0] count;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 0;
        sclk  <= 0;
        tick  <= 0;
    end
    else if (clk_en) begin
        if (count == CLK_DIV - 1) begin
            sclk  <= ~sclk;
            count <= 0;
            if (sclk == 0) tick  <= 1;
            else tick <= 0;
        end
        else begin
            count <= count + 1;
            tick  <= 0; 
        end
    end
    else begin
        count <= 0;
        sclk  <= 0;
        tick  <= 0;
    end
end
    
endmodule