// This macro loads ROIs, applies them to each channel of an image and then measures area, intensity etc in each channel.

dir1 = getDirectory("Choose a Directory"); // This is where the C0 images are.
list = getFileList(dir1); // This lists all the files in Ch1 folder
ROIDir= getDirectory("Choose a Directory"); // This is where the ROI zip files are.
list2= getFileList(ROIDir);
 // This lists all the files in the ROI folder.
SaveDir = getDirectory("Choose a Directory"); // This is where ch1 csv results files are to be stored.
run("Set Measurements...", "mean redirect=None decimal=3");

for (g=0; g<list.length; g++) { // This goes through each file in Ch1 iteratively
	ch1name = list[g]; // This takes the name of the file and makes it a variable called ch1name
	print(ch1name);
	open(dir1 + ch1name);
	rename ("C0"); // This renames the images to something simple for the image calculator below
	ids=newArray(nImages); //checks how many images are currently open
	n=nImages;
	
	for (i=0;i<nImages;i++) {
		selectImage(i+1);
		title = getTitle;
		
		if (endsWith(title, "C0")){
			//HERE YOU NEED to adjust the descriptor of your target channel. It selects it so that the ROI manager puts its ROIs onto the target channel.
			roiManager("open", ROIDir+list2[g]); // This loads ROIs of respective file from list.
			array1 = newArray("0");
			// This for loop creates an array containing the index of all ROIs in ROI manager.
			
			for (ii=1;ii<roiManager("count");ii++){
				array1 = Array.concat(array1,ii);
				}
			
			roiManager("select", array1); // This selects all the ROIs in the ROI manager using the indexes from array1
			roiManager("Multi Measure");
			selectWindow("Results"); // This just puts the results window at the foreground of the desktop
			saveAs("Measurements", SaveDir+ch1name +"-C1Results.csv"); // This saves the results as a meaningful name, else it will be re-written each time.
			run("Clear Results");
			}
			
			while (nImages>0) {
				selectImage(nImages);
				close();
				}
			}
		}