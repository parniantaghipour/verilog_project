module cache (reset , clk , adr , hit , rwb , data, cache2memwrite_data 
, cache2memread_adr , cache2memorywrite_adr , cache2mem_write_enable , cache2mem_read_enable
, read_data, mem_data);
input  reset , clk , rwb;
input [5:0] adr;
output hit, cache2mem_read_enable;
output cache2mem_write_enable ;
input [7:0] data, mem_data;
output [7:0] cache2memwrite_data , read_data ;
output [5:0] cache2memread_adr , cache2memorywrite_adr;
reg [26:0] cache [7:0];  // include 1d+1u+1v+3bit tag+8 bit data+1d+1v+3bit tag+8bit data = 27 bit
integer i ;
wire hit_1 , hit_2 ;
wire u , v1 , v0 , d1 , d0 ;
wire [7:0] data_1 , data_0;
wire [2:0] tag_1 , tag_0 ;

assign d1 = cache[adr[2:0]][26];
assign u = cache[adr[2:0]][25];
assign v1 = cache[adr[2:0]][24];
assign tag_1 = cache[adr[2:0]][23:21];
assign data_1 = cache[adr[2:0]][20:13];
assign d0 = cache[adr[2:0]][12];
assign v0 = cache[adr[2:0]][11];
assign tag_0 = cache[adr[2:0]][10:8];
assign data_0 = cache[adr[2:0]][7:0];
assign hit_1 = (tag_1 == adr[5:3]) & v1;
assign hit_0 = (tag_0 == adr[5:3]) & v0;
assign hit= hit_1 | hit_0;
// rwb =1  read   rwb=0  write
assign cache2mem_read_enable = rwb & (! hit);
assign cache2memread_adr = adr;
// u=1 way1 u=0 way 0     way1 way0
assign cache2mem_write_enable = u  ? d1 : d0; 
// it become 1 when dirty bit is 1
// if way0 is used  u=1  else u=0 
assign cache2memorywrite_adr = u ? {tag_1 , adr[2:0]} :{tag_0 , adr[2:0]} ;
assign cache2memwrite_data = u ? data_1 : data_0;
assign read_data = (hit_1) ? data_1 : (hit_0 ?data_0 : {8{1'bz}} ); 
assign cache2memread_adr = adr ;

always @(posedge clk)
begin
if (reset)
begin
for(i=0;i<=7;i=i+1)
begin
cache[i][26:0]<=27'b0;
end 
end
else if (!rwb )  // write
begin
if(hit_1)  
begin
cache[adr[2:0]][20:13] <= data;  // update data
cache[adr[2:0]][25] <= 0 ;  // used bit for next operation is zero
cache[adr[2:0]][26] <= 1 ; // dirty bit 
cache[adr[2:0]][24] <= 1 ; // validity bit;
end
else if (hit_0)
begin 
cache[adr[2:0]][7:0] <= data ; // update data
cache[adr[2:0]][25] <= 1;  // used bit for next operation is one
cache[adr[2:0]][12] <= 1 ; // dirty bit
cache[adr[2:0]][11] <= 1; // validity bit
end
else
begin
if (cache[adr[2:0]][25])// u bit 
begin
cache[adr[2:0]][20:13] <= data;  // update data
cache[adr[2:0]][25] <= 0 ;  // used bit for next operation is zero
cache[adr[2:0]][26] <= 1 ; // dirty bit 
cache[adr[2:0]][24] <= 1 ; // validity bit;
cache[adr[2:0]][23:21] <= adr[5:3]; // update tag
end
else
begin
cache[adr[2:0]][7:0] <= data ; // update data
cache[adr[2:0]][25] <= 1;  // used bit for next operation is one
cache[adr[2:0]][12] <= 1 ; // dirty bit
cache[adr[2:0]][11] <= 1; // validity bit
cache[adr[2:0]][10:8] <= adr[5:3]; // update tag
end
end
end
else // read
begin
if (hit_1)
begin
cache[adr[2:0]][25] <= 0; // u bit
cache[adr[2:0]][24] <= 1 ; // validity bit;
end
else if (hit_0)
begin
cache[adr[2:0]][25] <= 1; // u bit 
cache[adr[2:0]][11] <= 1; // validity bit
end
else 
begin
//               cache2mem_read_enable <= 1;
if (cache[adr[2:0]][25])// u bit 
begin
cache[adr[2:0]][20:13] <= mem_data;  // update data
cache[adr[2:0]][25] <= 0 ;  // used bit for next operation is zero
cache[adr[2:0]][26] <= 1 ; // dirty bit 
cache[adr[2:0]][24] <= 1 ; // validity bit;
cache[adr[2:0]][23:21] <= adr[5:3]; // update tag
end
else
begin
cache[adr[2:0]][7:0] <= mem_data ; // update data
cache[adr[2:0]][25] <= 1;  // used bit for next operation is one
cache[adr[2:0]][12] <= 1 ; // dirty bit
cache[adr[2:0]][11] <= 1; // validity bit
cache[adr[2:0]][10:8] <= adr[5:3]; // update tag
end
end
end
end
endmodule




