module file_reading(
  input clk,
  output reg [7:0]audio_data);

integer file_handle, status;

initial begin
  audio_data = 8'h00;
  file_handle = 0;
  status = 0;
  file_handle = $fopen("audio_data_file.txt", "r");
  while(!$feof(file_handle)) begin
    @(posedge clk)  
	   status = $fscanf(file_handle, "%8b", audio_data);
	 $display("data : %b", audio_data);
 end
   $fclose(file_handle);
end
endmodule 
