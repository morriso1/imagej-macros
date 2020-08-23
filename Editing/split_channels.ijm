D_Composite = getDirectory("Composite Directory");
D_Output_C0 = getDirectory("Output C0 folder");
D_Output_C1 = getDirectory("Output C1 folder");

list = getFileList(D_Composite); // This lists all the files in C0 folder

for (g=0; g<list.length; g++) { // This goes through each file in C0
	Composite_Name = list[g]; // This takes the name of the file and makes it a variable called C0_name
	Composite_Name_NoExt= replace(Composite_Name,"_composite.tif",""); 
	open(D_Composite + Composite_Name);
	run("Split Channels");
	selectWindow("C2-" + Composite_Name);
	saveAs("tiff", D_Output_C0 + Composite_Name_NoExt + "_C0");
	close();
	selectWindow("C1-" + Composite_Name);
	saveAs("tiff", D_Output_C1 + Composite_Name_NoExt + "_C1");
	close();
}