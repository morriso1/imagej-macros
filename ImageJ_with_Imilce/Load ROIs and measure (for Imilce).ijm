// This macro loads ROIs, applies them to each channel of an image and then measures area, intensity etc in each channel.

C1_Dir1 = getDirectory("Choose directory where C1 images are stored.");
C0_Dir1 = getDirectory("Choose directory where C0 images are stored.");
C1_FileList = getFileList(C1_Dir1); // This lists all the files in C1 folder.
ROIDir = getDirectory("Choose directory where ROI zip folders are stored");
C0_FileList = getFileList(ROIDir);// This lists all the files in the ROI folder.
Output_C1 = getDirectory("Choose a Directory"); // This is where ch1 csv results files are to be stored.
Output_C0 = getDirectory("Choose a Directory"); // This is where ch2 csv results files are to be stored.

for (g=0; g<C1_FileList.length; g++) { // This goes through each file in Ch1 iteratively
	C1_Name = C1_FileList[g]; // This takes the name of the file and makes it a variable called C1_Name
	C0_Name = replace(C1_Name, "C1", "C0"); // This generates Ch2name variable by replacing IDs. Choose a unique identifier in your images
	if (File.exists(C0_Dir1 + C0_Name)); { // This looks in the Ch2 folder for files matching C0_Name. If there is, then it enters the loop.
		print(C1_Name);
		open(C1_Dir1 + C1_Name);
		rename ("C1"); // This renames the images to something simple for later.
		print(C0_Name);
		open(C0_Dir1 + C0_Name);
		rename ("C0"); // This renames the images to something simple for later.
		for (i=0;i<nImages;i++) {
			selectImage(i+1);
			Title = getTitle;
			if (endsWith(Title, "C1")){ //HERE YOU NEED to adjust the descriptor of your target channel. It selects it so that the ROI manager puts its ROIs onto the target channel.
				roiManager("open", ROIDir+C0_FileList[g]); // This loads ROIs of respective file from list.
				Array1 = newArray("0"); 
				// This for loop creates an array containing the index of all ROIs in ROI manager.
					for (ii=1;ii<roiManager("count");ii++){ 
        			Array1 = Array.concat(Array1,ii); 
					}
				roiManager("select", Array1); // This selects all the ROIs in the ROI manager using the indexes from Array1 
				roiManager("Measure");
				selectWindow("Results"); // This just puts the results window at the foreground of the desktop
				saveAs("Measurements", Output_C1+C1_Name +"-C1Results.csv"); // This saves the results as a meaningful name, else it will be re-written each time.
				run("Clear Results");
				}
			if (endsWith(Title, "C0")){
				roiManager("select", Array1);
				roiManager("Measure");
				selectWindow("Results"); // This just puts the results window at the foreground of the desktop
				saveAs("Measurements", Output_C0+C1_Name +"-C0Results.csv"); // This saves the results as a meaningful name, else it will be re-written each time.
				roiManager("reset"); // If you don't reset the ROI manager will accumulate ROIs from each dataset that's loaded in.
				run("Clear Results");
				while (nImages>0) {
					selectImage(nImages);
					close();
					}
				}
			}
		}
	}
