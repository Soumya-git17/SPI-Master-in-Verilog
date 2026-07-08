`timescale 1ns/1ps
`include "spi_master_top.v"

module spi_master_tb;
reg clk, rst, start, miso;
reg [7:0] tx_data;
wire mosi, sclk, cs, done;
wire [7:0] rx_data;

spi_master_top dut(clk, rst, start, tx_data, miso, mosi, sclk, cs, rx_data, done);

initial begin
    clk = 0;
    forever #10 clk=~clk;
end

initial begin
    $dumpfile("spi_master_tb.vcd");
    $dumpvars(0, spi_master_tb);
    // $monitor("T=%0t | CS=%b SCLK=%b MISO=%b MOSI=%b DONE=%b RX_DATA=%b",
    //         $time, cs, sclk, miso, mosi, done, rx_data);
end

reg [7:0] slave_data;
reg [7:0] mosi_capture;

integer i;
integer pass_count, fail_count;

always @(posedge sclk) begin
    if (!cs) begin
        miso <= slave_data[7];
        slave_data <= {slave_data[6:0],1'b0};
        mosi_capture <= {mosi_capture[6:0],mosi};
    end
end

task spi_test;
input [7:0] master_tx;
input [7:0] slave_tx;
begin
    mosi_capture = 0;
    tx_data = master_tx;
    slave_data = slave_tx;
    @(posedge clk); start = 1;
    @(posedge clk); start = 0;
    wait(done);
    #20;
    // if (rx_data == slave_tx)
    //     $display("PASS. Received %b", rx_data);
    // else
    //     $display("FAIL. Received %b in stead of %b", rx_data, slave_tx);
    // if(mosi_capture==tx_data)
    //     $display("TX PASS Received=%b", mosi_capture);
    // else
    //     $display("TX FAIL Expected=%b Got=%b", master_tx, mosi_capture);
    if(rx_data == slave_tx && mosi_capture == master_tx)
        pass_count = pass_count + 1;
    else begin
        fail_count = fail_count + 1;
        $display("Master TX Expected : %b", master_tx);
        $display("Master TX Received : %b", mosi_capture);
        $display("Slave TX Expected  : %b", slave_tx);
        $display("Master RX Received : %b", rx_data);
    end
end
endtask


initial begin
    pass_count = 0;
    fail_count = 0;
    rst = 1;
    start = 0;
    tx_data = 0;
    miso = 0;
    #30;
    rst = 0;
    repeat (50) spi_test($random, $random);
    $display("PASS = %0d", pass_count);
    $display("FAIL = %0d", fail_count);
    #30;
    $finish;
end

endmodule