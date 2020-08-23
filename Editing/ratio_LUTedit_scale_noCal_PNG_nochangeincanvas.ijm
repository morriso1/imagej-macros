// This macro edits LUT of ratio images, adds scale bar and calibration bar
// and saves as an RGB colour PNG.

lowLUT=0;
highLUT=3;
dec=1 // number decimal places on calibration bar

dir1 = getDirectory("Choose a Directory"); // This is where the ratio images are
list = getFileList(dir1); // This lists all the files in ratio image folder
SaveDir = getDirectory("Choose a Directory"); // This is PNG files are saved

for (g=0; g<list.length; g++) { // This goes through each file in Ch1 iteratively
ch1name = list[g]; // This takes the name of the file and makes it a variable called ch1name

print(ch1name);
open(dir1 + ch1name);

run("Brightness/Contrast...");
setMinAndMax(lowLUT, highLUT);
run("Fire");
run("Scale Bar...", "width=20 height=4 font=20 color=White background=None location=[Lower Right] bold overlay");
run("RGB Color");

saveAs("PNG", SaveDir+ch1name+"_"+lowLUT+"_"+highLUT);
while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      }
}
