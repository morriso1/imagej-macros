// This macro thresholds the C1 channel, draws ROIs on the masked image and saves the Masks and ROIs (zip folders) in folders.

Dir1 = getDirectory("Choose directory where ch00 images are stored"); // This is where the C0_Dapi images are.
FileList = getFileList(Dir1); // This lists all the files in C0 directory
MasksDir = getDirectory("Directory where MASKS will be saved"); // This is where Masks will be saved.
ROIDir= getDirectory("A directory where ROI zip folders will be saved"); // This is where the ROI zip folders will be saved.

// Open Weka Plugin
run("Trainable Weka Segmentation","open=[C:/Users/rodrii26/Desktop/Imilce projects/6_Nrf2 lung cells/Tracheo Exp1/Tiffs for Macro/sld1 ch00_Selected/sld1 WT54 EtOH_area2_ch00.tif]");
selectWindow("Trainable Weka Segmentation v3.2.33");
wait(900) // 90 second wait time to allow for classifier to load
// Load trained model
call("trainableSegmentation.Weka_Segmentation.loadClassifier", "C:\\Users\\rodrii26\\Desktop\\Script for Analizing spheres\\Weka\\classifier_v2_training22_WTarea2.model");

for (g=0; g<FileList.length; g++) { // This goes through each file in Ch0 iteratively
	C0name = FileList[g]; // This takes the name of the file and makes it a variable called C0name

	print(C0name);
	// run Weka Segmentation to detect automatically ROIs
	call("trainableSegmentation.Weka_Segmentation.applyClassifier", Dir1, C0name, "showResults=true", "storeResults=false", "probabilityMaps=true", "");

	selectWindow("Classification result");
	run("Stack to Images"); // split images into two separate stacks (classification and background)
	selectWindow("nuclei");

	run("Make Binary");
	run("Erode");
	run("Watershed");
	run("Analyze Particles...", "size=10-Infinity circularity=0.30-1.00 display exclude clear add");

	// no more processing
	run("Clear Results"); // required to prevent accumulation of results
	roiManager("save", ROIDir+C0name+".zip") // save ROIs as zip folders
	
	saveAs("tiff", MasksDir+C0name+"C0C1mask"); // save masks for reference
	roiManager("reset"); // If you don't reset the ROI manager will accumulate ROIs from each dataset that's loaded in.
while (nImages>1) { 
          selectImage(nImages);
          close(); 
      }
}
