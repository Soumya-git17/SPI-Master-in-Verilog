module spi_controller (
    input clk, rst, start, count_done, tick,
    output reg cs, clk_en, count_en, clear, load, shift, done
);

localparam  IDLE = 2'b00,
            LOAD = 2'b01,
        TRANSFER = 2'b10,
            DONE = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk or posedge rst) begin
    if (rst) state <= IDLE;
    else state <= next_state;
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: if (start) next_state = LOAD;
        LOAD: next_state = TRANSFER;
        TRANSFER: if (count_done) next_state = DONE;
        DONE: next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

always @(*) begin
    case(state)
        IDLE: begin
            cs       = 1'b1;
            clk_en   = 1'b0;
            count_en = 1'b0;
            clear    = 1'b0;
            load     = 1'b0;
            shift    = 1'b0;
            done     = 1'b0;
        end
        LOAD: begin
            cs       = 1'b0;
            clk_en   = 1'b0;
            count_en = 1'b0;
            clear    = 1'b1;
            load     = 1'b1;
            shift    = 1'b0;
            done     = 1'b0;
        end
        TRANSFER: begin
            cs       = 1'b0;
            clk_en   = 1'b1;
            count_en = tick;
            clear    = 1'b0;
            load     = 1'b0;
            shift    = tick;
            done     = 1'b0;
        end
        DONE: begin
            cs       = 1'b1;
            clk_en   = 1'b0;
            count_en = 1'b0;
            clear    = 1'b0;
            load     = 1'b0;
            shift    = 1'b0;
            done     = 1'b1;
        end
        default: begin
            cs       = 1'b1;
            clk_en   = 1'b0;
            count_en = 1'b0;
            clear    = 1'b0;
            load     = 1'b0;
            shift    = 1'b0;
            done     = 1'b0;
        end
    endcase
end

endmodule