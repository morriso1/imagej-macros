Dir1 = getDirectory("Choose a Directory"); // This is where the Ch1 images are
list = getFileList(Dir1); // This lists all the files in Ch1 folder
ROIDir= getDirectory("Choose a Directory"); // This is where the ROI zip folders are stored.

for (g=0; g<list.length; g++) { // This goes through each file in Ch1 iteratively
	ch1name = list[g]; // This takes the name of the file and makes it a variable called ch1name
	print(ch1name);
	open(Dir1 + ch1name);
	
	// insert processing here
	run("8-bit");
	setOption("BlackBackground", true);
	run("Make Binary");
	run("Open");
	run("Erode");
	run("Open");
	run("Analyze Particles...", "size=10-Infinity circularity=0.5-1.00 display exclude clear add");
	run("Clear Results"); // required to prevent accumulation of results
	roiManager("save", ROIDir+ch1name+".zip") // save ROIs as zip folders
	roiManager("reset"); // If you don't reset the ROI manager will accumulate ROIs from each dataset that's loaded in.
while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      }
}
