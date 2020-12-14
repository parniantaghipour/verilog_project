module hazard ( RsE , RtE , WriteRegE , WriteRegM , RsD , RtD , stallF , stallD , flushE , forwardAD , forwardBD , forwardAE , forwardBE , RegWriteM , RegWriteW , MemtoRegE , WriteRegW , PCsrcD , RegWriteE ,MemtoRegM);
input [4:0] RsD , RtD , RsE , RtE , WriteRegE , WriteRegM , WriteRegW ;
input RegWriteM , MemtoRegE , RegWriteW,PCsrcD ,RegWriteE , MemtoRegM;
output  stallF , stallD ,flushE, forwardAD , forwardBD ;
output [1:0] forwardAE , forwardBE ;
assign forwardAE =((RsE != 0)&& (RsE== WriteRegM) && (RegWriteM)) ? 2'b10 : ((RsE != 0)&& (RsE== WriteRegW)&& (RegWriteW)) ? 2'b01 :  2'b00 ;

assign forwardBE =((RtE != 0)&& (RtE== WriteRegM) && (RegWriteM)) ? 2'b10 : ((RtE != 0)&& (RtE== WriteRegW)&& (RegWriteW)) ? 2'b01 :  2'b00 ;
			
		  
 assign stallF = (((RsD== RtE) | (RtD== RtE)) && MemtoRegE) || (PCsrcD && RegWriteE && (WriteRegE == RsD || WriteRegE == RtD) || (PCsrcD && MemtoRegM && (WriteRegM == RsD || WriteRegM == RtD)));
 assign stallD = (((RsD== RtE) | (RtD== RtE)) && MemtoRegE) || (PCsrcD && RegWriteE && (WriteRegE == RsD || WriteRegE == RtD) || (PCsrcD && MemtoRegM && (WriteRegM == RsD || WriteRegM == RtD)));  	
 assign flushE = (((RsD== RtE) | (RtD== RtE)) && MemtoRegE) || (PCsrcD && RegWriteE && (WriteRegE == RsD || WriteRegE == RtD) || (PCsrcD && MemtoRegM && (WriteRegM == RsD || WriteRegM == RtD)));		
		
 assign forwardAD=((RsD != 0 ) && (RsD == WriteRegM) && ( RegWriteM ));
 assign forwardBD=((RtD != 0 ) && (RtD == WriteRegM) && ( RegWriteM ));

	
endmodule

