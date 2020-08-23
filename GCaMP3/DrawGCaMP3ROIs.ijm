dir1 = getDirectory("Select C1 image directory");
list = getFileList(dir1);
SaveMaskDir = getDirectory("Select mask save directory");
SaveMaxOverTimeImage = getDirectory("Select save directory");
ROIDir= getDirectory("Select ROI save directory");

for (g=0; g<list.length; g++) { 
	ch1name = list[g];
	print(ch1name);
	open(dir1 + ch1name);
	// insert processing here
	run("8-bit");
	run("Z Project...", "projection=[Max Intensity]");
	run("Subtract Background...", "rolling=100");
	run("Gaussian Blur...", "sigma=0.50");
	saveAs("tiff", SaveMaxOverTimeImage + ch1name + "MaxProjOverTimeSubBac"); // save max proj over time
	run("Auto Threshold", "method=Li white");
	setOption("BlackBackground", true);
	run("Make Binary");
	run("Open");
	run("Watershed");
	// processing ends
	run("Analyze Particles...", "size=20-Infinity circularity=0.33-1.00 display exclude clear add");
	run("Clear Results"); 
	saveAs("tiff", SaveMaskDir + ch1name + "C0C1mask"); // save masks for reference
	roiManager("save", ROIDir+ch1name+".zip");
	roiManager("reset"); // If you don't reset the ROI manager will accumulate ROIs from each dataset that's loaded in.
	
	while (nImages>0) {
		selectImage(nImages);
		close();
		}
}