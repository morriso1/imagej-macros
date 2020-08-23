// This macro thresholds each channel individually, adds the binary images together, draws ROIs on this summed image and saves the respective ROIs in zip folders.

dir1 = getDirectory("Choose a Directory"); // This is where the Ch1 images are
dir2 = getDirectory("Choose a Directory"); // This is where the Ch2 images are
list = getFileList(dir1); // This lists all the files in Ch1 folder
SaveDir = getDirectory("Choose a Directory"); // This is where results/processed images are stored
ROIDir= getDirectory("Choose a Directory"); // This is where the ROI zip folders are stored.

for (g=0; g<list.length; g++) { // This goes through each file in Ch1 iteratively
ch1name = list[g]; // This takes the name of the file and makes it a variable called ch1name
ch2name = replace(ch1name, "C1", "C0"); // This generates Ch2name variable by replacing IDs. Choose a unique identifier in your images
if (File.exists(dir2 + ch2name)); { // This looks in the Ch2 folder for files matching ch2name. If there is, then it enters the loop.

print(ch1name);
open(dir1 + ch1name);
rename ("C1"); // This renames the images to something simple for the image calculator below
print(ch2name);
open(dir2 + ch2name);
rename ("C0"); // This renames the images to something simple for the image calculator below

// Step 2: generate ROIs from the GFP channel

ids=newArray(nImages); //checks how many images are currently open
n=nImages;
for (i=0;i<nImages;i++) {
selectImage(i+1);
title = getTitle; // registers the names of all open images

if (endsWith(title, "C1")){
run("Auto Threshold", "method=Li white");
setOption("BlackBackground", true);
run("Make Binary");
run("Erode");
}

if (endsWith(title, "C0")){
run("Auto Threshold", "method=RenyiEntropy white");
setOption("BlackBackground", true);
run("Make Binary");
run("Erode");
}
}
}
imageCalculator("Add create", "C0","C1");
selectWindow("Result of C0");
run("Create Selection");
run("Make Inverse");
roiManager("Add");
roiManager("save", ROIDir+ch1name+".zip"); // save ROIs as zip folders
saveAs("tiff", SaveDir+ch1name+"C0C1mask"); // save masks for reference
roiManager("reset"); // If you don't reset the ROI manager will accumulate ROIs from each dataset that's loaded in.
while (nImages>0) { 
          selectImage(nImages); 
          close();
  } 
}
