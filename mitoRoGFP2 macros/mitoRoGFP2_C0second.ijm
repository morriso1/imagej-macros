// Instructions: Make folders for C488 and C405 images (copy them into the folder). Also make an ‘output’

//What does the macro do?
// Sequentially opens a set of C488/C405 images
// mask generation in the C488 channel that is then applied to the C405 signal image for measuring.
//A results table will appear at the end which is saved containing measurements from each individual object (cell)

// The small macro below utilises data with 2 channels, put into different folders. It will find the file in one folder and look for a similar named file, but with the channel descriptor, in another folder.

dir1 = getDirectory("Choose a Directory"); // This is where the C488 images are
list = getFileList(dir1); // This lists all the files in C488 folder
dir2 = getDirectory("Choose a Directory"); // This is where the C405 images are
SaveDir = getDirectory("Choose a Directory"); // This is the output folder for masks and results.
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

// Step 2: generate ROIs from the C488 channel

ids=newArray(nImages); //checks how many images are currently open
n=nImages;
for (i=0;i<nImages;i++) {
selectImage(i+1);
title = getTitle; // registers the names of all open images
if (endsWith(title, "C1")){

// enter your processing here

run("Auto Threshold", "method=RenyiEntropy white");
run("Erode");
run("Set Measurements...", "area mean min redirect=None decimal=3");
run("Analyze Particles...", "size=5-Infinity display exclude add");
run("Clear Results");

if (endsWith(title, "C1")){
saveAs("tiff", SaveDir+ch1name+"mask");
}
}
}

// Step3: apply the ROIs to the C405 channel

ids=newArray(nImages); //checks how many images are currently open
n=nImages;
for (i=0;i<nImages;i++) {
selectImage(i+1);
title = getTitle;

  if (endsWith(title, "C0")){ //HERE YOU NEED to adjust the descriptor of your target channel. It selects it so that the ROI manager puts its ROIs onto the target channel.
     roiManager("Show All"); // this applies the masks to the target channel
  roiManager("Measure");
  roiManager("reset"); // If you don't reset the ROI manager will accumulate ROIs from each dataset that's loaded in.
  selectWindow("Results"); // This just puts the results window at the foreground of the desktop
  saveAs("Measurements", SaveDir+ch1name +"-C0Results.csv"); // This saves the results as a meaningful name, else it will be re-written each time.
  close();
  }
}	
}
}
