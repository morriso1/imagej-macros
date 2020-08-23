ROI_Dir= getDirectory("Choose a Directory");
r_list = getFileList(ROI_Dir);
Save_Dir = getDirectory("Choose a Directory");

for (g=0; g < r_list.length; g++) {
	newImage("Binary_Image", "8-bit black", 512, 512, 1);
	roiManager("open", ROI_Dir+r_list[g]);
	
	array1 = newArray("0");  
	for (ii=1;ii<roiManager("count");ii++){
		array1 = Array.concat(array1,ii); 
	}
	
	roiManager("select", array1);
	roiManager("Fill");

	no_channel_name = replace(r_list[g], ".tiff.zip", "");
	
	saveAs("tiff", Save_Dir + no_channel_name); // save ratio images
	
	roiManager("reset");
	
	while (nImages>0) {
		selectImage(nImages);
		close();
	}
}