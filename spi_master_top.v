`include "clk_div.v"
`include "bit_counter.v"
`include "shift_reg.v"
`include "spi_controller.v"

module spi_master_top (
    input clk, rst, start,
    input [7:0] tx_data,
    input miso,
    output mosi, sclk, cs,
    output [7:0] rx_data,
    output done
);

wire clk_en, count_en, clear, count_done, load, shift, tick;

clk_div #(4) cd (clk, rst, clk_en, sclk, tick);
bit_counter bc (clk, rst, count_en, clear, count_done);
shift_reg sr (clk, rst, load, shift, tx_data, miso, mosi, rx_data);
spi_controller sc(clk, rst, start, count_done, tick, cs, clk_en, count_en, clear, load, shift, done);

endmodule