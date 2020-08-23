// This macro add two binary files together, draws ROIs on this summed image and saves the respective ROIs in zip folders.

Dir_C1 = getDirectory("Choose a Directory"); 
Dir_C0 = getDirectory("Choose a Directory"); 
List_Dir_C1 = getFileList(Dir_C1);
SummedBinary_SaveDir = getDirectory("Choose a Directory"); 
ROI_SaveDir= getDirectory("Choose a Directory");

for (g=0; g<List_Dir_C1.length; g++) {
	C1_name = List_Dir_C1[g];
	C0_name = replace(C1_name, "C1", "C0"); // This generates C0_name variable by replacing NumImagesOpen.
	
	if (File.exists(Dir_C0 + C0_name)); { // This looks in Dir_C0 for files matching C0_name. If there is, then it enters the loop.
		open(Dir_C1 + C1_name);
		rename ("C1"); // This renames the images to something simple for the image calculator below
		open(Dir_C0 + C0_name);
		rename ("C0"); // This renames the images to something simple for the image calculator below
		
		NumImagesOpen = newArray(nImages());
		n=nImages();

		for (i=0;i<nImages();i++) {
			selectImage(i+1);
			NameOfSelectedImage = getTitle(); // registers the names of all open images
			
			if (endsWith(NameOfSelectedImage, "C1")){
				// Insert own processing here for C1 binary images.
				run("8-bit");
				run("Make Binary");
				}
		
			if (endsWith(NameOfSelectedImage, "C0")){
				// Threshold C0. Insert own processing here
				run("8-bit");
				run("Make Binary");
			}
		}
	}
	
	imageCalculator("Add create", "C0","C1"); // adds binary images of C0 and C1 together
	selectWindow("Result of C0");
	run("Open");
	run("Erode");
	run("Open");
	run("Set Measurements...", "area mean min redirect=None decimal=3");
	run("Analyze Particles...", "size=5-Infinity display exclude clear add");
	run("Clear Results"); // required to prevent accumulation of results
	
	roiManager("save", ROI_SaveDir+C1_name+".zip"); // save ROIs as zip folders
	saveAs("tiff", SummedBinary_SaveDir+C1_name+"C0C1_summedBinary");
	roiManager("reset"); // If you don't reset the ROI manager will accumulate ROIs from each dataset that's loaded in.
	while (nImages()>0) {
		selectImage(nImages());
		close();
		}
	}
