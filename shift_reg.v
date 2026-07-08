module shift_reg #(parameter DATA_WIDTH = 8) (
    input clk, rst, load, shift,
    input [DATA_WIDTH-1:0] tx_data,
    input miso,
    output mosi,
    output [DATA_WIDTH-1:0] rx_data
);

reg [DATA_WIDTH-1:0] tx_shift_reg, rx_shift_reg;

assign mosi = tx_shift_reg[DATA_WIDTH-1];
assign rx_data = rx_shift_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        tx_shift_reg <= 0;
        rx_shift_reg <= 0;
    end
    else begin
        if (load) begin
            tx_shift_reg <= tx_data;
            rx_shift_reg <= 0;
        end
        else if (shift) begin
            tx_shift_reg <= {tx_shift_reg[DATA_WIDTH-2:0],1'b0};
            rx_shift_reg <= {rx_shift_reg[DATA_WIDTH-2:0],miso};
        end
    end
end

endmodule