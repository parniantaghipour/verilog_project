module memory_system (clk , reset, hit , read_data);
input clk , reset ;
output hit ;
output [7:0] read_data;
wire rwb  , cache2mem_write_enable , cache2mem_read_enable ;
wire [5:0] adr , cache2memread_adr , cache2memorywrite_adr;
wire [7:0] data , cache2memwrite_data , read_data1 , mem_data ;

Processor Processor (.clk (clk), .start (reset) ,.RWB (rwb),.Address (adr ), .Data (data));

cache cache ( .reset(reset) , .clk(clk) , .adr(adr) , .hit(hit) , .rwb(!rwb) , .data(data),
 .cache2memwrite_data(cache2memwrite_data) , .cache2memread_adr(cache2memread_adr) ,
 .cache2memorywrite_adr(cache2memorywrite_adr) , .cache2mem_write_enable(cache2mem_write_enable) ,
 .cache2mem_read_enable(cache2mem_read_enable ) ,  .read_data(read_data1), .mem_data(mem_data));

 RAM RAM (.ReadData(mem_data) , .WriteData(cache2memwrite_data) , .Reset(reset) ,
  .readAddress(cache2memread_adr) , .writeAddress(cache2memorywrite_adr) , .Clk(clk) ,
   .writeEn(cache2mem_write_enable) , .readEn(cache2mem_read_enable));

assign read_data = rwb ? 8'h00 :(hit ? read_data1 : mem_data);
endmodule