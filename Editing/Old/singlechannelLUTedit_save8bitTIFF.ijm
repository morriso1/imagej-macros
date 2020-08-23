// This macro thresholds each channel individually, adds the binary images together, draws ROIs on this summed image and saves the respective ROIs in zip folders.

dir1 = getDirectory("Choose a Directory"); // This is where the Ch1 images are
list = getFileList(dir1); // This lists all the files in Ch1 folder
SaveDir = getDirectory("Choose a Directory"); // This is where results/processed images are stored

for (g=0; g<list.length; g++) { // This goes through each file in Ch1 iteratively
ch1name = list[g]; // This takes the name of the file and makes it a variable called ch1name

print(ch1name);
open(dir1 + ch1name);
lowLUT=600;
highLUT=4000;
//run("Brightness/Contrast...");
setMinAndMax(lowLUT, highLUT);
run("8-bit");
saveAs("tiff", SaveDir+ch1name+"_"+lowLUT+"_"+highLUT); // save masks for reference
while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      }
}
