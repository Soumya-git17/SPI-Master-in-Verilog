module bit_counter #(parameter DATA_WIDTH = 8) (
    input clk, rst, count_en, clear,
    output reg done
);

reg [$clog2(DATA_WIDTH)-1:0] count;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 0;
        done <= 0;
    end
    else if (clear) begin
        count <= 0;
        done <= 0;
    end
    else begin
        done <= 0;
        if (count_en) begin
            if (count == DATA_WIDTH-1) begin
                count <= 0;
                done <= 1;
            end
            else count <= count + 1;
        end
    end
end

endmodule