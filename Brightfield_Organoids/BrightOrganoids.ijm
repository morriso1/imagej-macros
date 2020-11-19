dir1 = getDirectory("Select C1 image directory"); 
list = getFileList(dir1);
SaveDir = getDirectory("Select mask save directory");
ROIDir= getDirectory("Select ROI save directory");

for (g=0; g<list.length; g++) {
	ch1name = list[g];
	print(ch1name);
	open(dir1 + ch1name);
	run("8-bit");
	run("Invert");
	run("Find Edges");
	run("Auto Threshold", "method=Huang white");
	setOption("BlackBackground", true);
	run("Make Binary");
	run("Open");
	run("Analyze Particles...", "size=10000-Infinity circularity=0.00-1.00 display exclude clear add");
	run("Clear Results");
	roiManager("save", ROIDir+ch1name+".zip");
	saveAs("tiff", SaveDir+ch1name+"C0C1mask");
	roiManager("reset");
	
	while (nImages>0) {
		selectImage(nImages);
		close();
		}
}
