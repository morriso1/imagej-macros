dir1 = getDirectory("Select Directory with 16 bit TIFF files");
list = getFileList(dir1);
SaveDir = getDirectory("This is where 8 bit PNG files are to be saved");

LUTlow = 800;
LUThigh = 2000;

for (g=0; g<list.length; g++) {
	ch1name = list[g];
	print(ch1name);
	open(dir1 + ch1name);
	run("Brightness/Contrast...");
	setMinAndMax(LUTlow, LUThigh);

	run("8-bit");
	run("Scale Bar...", "width=20 height=4 font=20 color=White background=None location=[Lower Right] bold overlay");
	saveAs("PNG", SaveDir + ch1name);
	while (nImages>0) {
		selectImage(nImages);
		close();
	}
}
