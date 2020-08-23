// This macro thresholds each channel individually, adds the binary images together, draws ROIs on this summed image and saves the respective ROIs in zip folders.

dir1 = getDirectory("Choose a Directory"); // This is where the Ch1 images are
list = getFileList(dir1); // This lists all the files in Ch1 folder
SaveDir = getDirectory("Choose a Directory"); // This is where results/processed images are stored
ROIDir= getDirectory("Choose a Directory"); // This is where the ROI zip folders are stored.

for (g=0; g<list.length; g++) { // This goes through each file in Ch1 iteratively
ch1name = list[g]; // This takes the name of the file and makes it a variable called ch1name

print(ch1name);
open(dir1 + ch1name);
// insert processing here
run("Gaussian Blur...", "sigma=0.50");
run("Auto Threshold", "method=Default white");
setOption("BlackBackground", true);
run("Make Binary");
run("Watershed");
run("Open");
run("Analyze Particles...", "size=10-Infinity circularity=0.33-1.00 display exclude clear add");
run("Clear Results"); // required to prevent accumulation of results
roiManager("save", ROIDir+ch1name+".zip") // save ROIs as zip folders
saveAs("tiff", SaveDir+ch1name+"C0C1mask"); // save masks for reference
roiManager("reset"); // If you don't reset the ROI manager will accumulate ROIs from each dataset that's loaded in.
while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      }
}
