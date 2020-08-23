// This macro thresholds the C1 channel, draws ROIs on the masked image and saves the Masks and ROIs (zip folders) in folders.

Dir1 = getDirectory("Choose directory where C1 images are stored"); // This is where the C1 images are.
FileList = getFileList(Dir1); // This lists all the files in C1 directory
MasksDir = getDirectory("Directory where masks will be saved"); // This is where Masks will be saved.
ROIDir= getDirectory("A directory where ROI zip folders will be saved"); // This is where the ROI zip folders will be saved.

for (g=0; g<FileList.length; g++) { // This goes through each file in Ch1 iteratively
	C1name = FileList[g]; // This takes the name of the file and makes it a variable called C1name
	print(C1name);
	open(Dir1 + C1name);
	// insert processing and analyse particles detection parameters here
	run("Auto Threshold", "method=MaxEntropy ignore_white white");
	setOption("BlackBackground", true);
	run("Make Binary");
	run("Erode");
	run("Open");
	run("Erode");
	run("Watershed");
	run("Analyze Particles...", "size=10-Infinity circularity=0.30-1.00 display exclude clear add");
	// no more processing
	run("Clear Results"); // required to prevent accumulation of results
	roiManager("save", ROIDir+C1name+".zip") // save ROIs as zip folders
	saveAs("tiff", MasksDir+C1name+"C0C1mask"); // save masks for reference
	roiManager("reset"); // If you don't reset the ROI manager will accumulate ROIs from each dataset that's loaded in.
while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      }
}
