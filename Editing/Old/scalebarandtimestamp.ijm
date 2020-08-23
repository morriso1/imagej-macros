dir1 = getDirectory("Choose a Directory"); // This is where the Ch1 images are
list = getFileList(dir1); // This lists all the files in Ch1 folder
SaveDir = getDirectory("Choose a Directory"); // This is where results/processed images are stored

for (g=0; g<list.length; g++) { // This goes through each file in Ch1 iteratively
ch1name = list[g]; // This takes the name of the file and makes it a variable called ch1name

print(ch1name);
open(dir1 + ch1name);
// insert processing here
run("Label...", "format=00:00 starting=0 interval=15 x=5 y=29 font=24 text=[] range=1-48 use use_text");
run("Scale Bar...", "width=40 height=4 font=24 color=White background=None location=[Upper Right] bold overlay label");
saveAs("tiff", SaveDir+ch1name+"scaletime"); // 
while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      }
}
