run("Bio-Formats Macro Extensions");

Input_Directory = getDirectory("Composite Directory");
Output_Directory = getDirectory("Output C0 folder");

list = getFileList(Input_Directory); // This lists all the files in C0 folder

for (g=0; g<list.length; g++) { // This goes through each file in C0
	Image_Name = list[g]; // This takes the name of the file and makes it a variable called C0_name

	Ext.openImagePlus(Input_Directory + Image_Name);
	run("Split Channels");
	selectWindow("C1-" + Image_Name);
	saveAs("tiff", Output_Directory + Image_Name + "_C0");
	close();
	selectWindow("C2-" + Image_Name);
	saveAs("tiff", Output_Directory + Image_Name + "_C1");
	close();
}