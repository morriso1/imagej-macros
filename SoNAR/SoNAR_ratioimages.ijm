// This macro loads ROIs, applies them to each channel of an image and then measures area, intensity etc in each channel.

dir1 = getDirectory("Choose a Directory");
dir2 = getDirectory("Choose a Directory");
list = getFileList(dir1);
ROIDir= getDirectory("Choose a Directory");
list2= getFileList(ROIDir);
SaveDir = getDirectory("Choose a Directory");

for (g=0; g<list.length; g++) {
	ch1name = list[g];
	ch2name = replace(ch1name, "C1", "C0");
	
	if (File.exists(dir2 + ch2name)); {
		print(ch1name);
		open(dir1 + ch1name);
		rename ("C1"); // This renames the images to something simple for the image calculator below
		print(ch2name);
		open(dir2 + ch2name);
		rename ("C0"); // This renames the images to something simple for the image calculator below

		ids=newArray(nImages); //checks how many images are currently open
		n=nImages;
		
		for (i=0;i<nImages;i++) {
			selectImage(i+1);
			title = getTitle;
			
			if (endsWith(title, "C1")){
				roiManager("open", ROIDir+list2[g]); // This loads ROIs of respective file from list.
				array1 = newArray("0");  // This for loop creates an array containing the index of all ROIs in ROI manager.
				
				for (ii=1;ii<roiManager("count");ii++){
					array1 = Array.concat(array1,ii);
					}
				
				roiManager("select", array1); // This selects all the ROIs in the ROI manager using the indexes from array1 
				roiManager("combine");
				setBackgroundColor(0, 0, 0);
				run("Clear Outside"); // This deletes image outside ROIs
				run("32-bit");
				}
			
			if (endsWith(title, "C0")){
				roiManager("select", array1);
				roiManager("combine");
				setBackgroundColor(0, 0, 0);
				run("Clear Outside"); // This deletes image outside ROIs
				run("32-bit");
				}
	}
	
	imageCalculator("Divide create 32-bit", "C0","C1");
	selectWindow("Result of C0");
	run("Fire");
	setMinAndMax(0, 4);
	saveAs("tiff", SaveDir+ch1name+"ratiometric"); // save ratio images
	roiManager("reset"); // If you don't reset the ROI manager will accumulate ROIs from each dataset that's loaded in.
	
	while (nImages>0) {
		selectImage(nImages);
		close();
		}
	}
}
