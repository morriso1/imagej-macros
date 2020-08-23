// Macro alters LUTs for each channel of a two channel composite
// edit variables below for desired red and green channel LUTs
RedLowLUT=15;
RedHighLUT=400;

GreenLowLUT=15;
GreenHighLUT=1000;

dir1 = getDirectory("Choose a Directory"); // This is where the Ch1 images are
list = getFileList(dir1); // This lists all the files in Ch1 folder
SaveDir = getDirectory("Choose a Directory"); // This is where results/processed images are stored

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
run("Label...", "format=00:00 starting=0 interval=8 x=5 y=20 font=28 text=[] range=1-120 use");
run("Scale Bar...", "width=10 height=4 font=28 color=White background=None location=[Lower Right] bold overlay label");
saveAs("tiff", SaveDir+ch1name+"scaletime"); // saves composites

while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      }
}
