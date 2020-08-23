// This m// This macro thresholds C1 images and outputs masks and ROIs.

dir1 = getDirectory("Select C1 image directory"); // This is where the Ch1 images are
list = getFileList(dir1); // This lists all the files in Ch1 folder
SaveDir = getDirectory("Select mask save directory"); // This is where results/processed images are stored
ROIDir= getDirectory("Select ROI save directory"); // This is where the ROI zip folders are stored.

for (g=0; g<list.length; g++) { // This goes through each file in Ch1 iteratively
	ch1name = list[g]; // This takes the name of the file and makes it a variable called ch1name
	print(ch1name);
	open(dir1 + ch1name);
	// insert processing here
	run("8-bit");
	run("Invert");
	run("Find Edges");
	run("Auto Threshold", "method=Huang white");
	setOption("BlackBackground", true);
	run("Make Binary");
	run("Open");
	run("Analyze Particles...", "size=10000-Infinity circularity=0.00-1.00 display exclude clear add");
	run("Clear Results"); // required to prevent accumulation of results
	roiManager("save", ROIDir+ch1name+".zip") // save ROIs as zip folders
	saveAs("tiff", SaveDir+ch1name+"C0C1mask"); // save masks for reference
	roiManager("reset"); // If you don't reset the ROI manager will accumulate ROIs from each dataset that's loaded in.
	
	while (nImages>0) {
		selectImage(nImages);
		close();
		}
}
