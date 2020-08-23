// Macro alters LUTs for each channel of a two channel composite
// edit variables below for desired red and green channel LUTs
RedLowLUT=15;
RedHighLUT=350;

GreenLowLUT=15;
GreenHighLUT=900;

dir1 = getDirectory("Choose a Directory"); // This is where the Ch1 images are
list = getFileList(dir1); // This lists all the files in Ch1 folder
SaveDir = getDirectory("Choose a Directory");

for (g=0; g<list.length; g++) { // This goes through each file in Ch1 iteratively
ch1name = list[g]; // This takes the name of the file and makes it a variable called ch1name

print(ch1name);
open(dir1 + ch1name);

Stack.setChannel(1);
//run("Brightness/Contrast...");
setMinAndMax(RedLowLUT, RedHighLUT);
Stack.setChannel(2);
//run("Brightness/Contrast...");
setMinAndMax(GreenLowLUT, GreenHighLUT);
run("AVI... ", "compression=JPEG frame=10 save=[" + SaveDir + ch1name + "] ");

while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      }
}
