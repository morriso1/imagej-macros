dir1 = getDirectory("Choose a Directory");
list = getFileList(dir1);
ROIDir= getDirectory("Choose a Directory");
list2= getFileList(ROIDir);
SaveDir = getDirectory("Choose a Directory");
run("Set Measurements...", "mean redirect=None decimal=3");

for (g=0; g<list.length; g++) {
	ch1name = list[g];
	print(ch1name);
	open(dir1 + ch1name);
	rename ("C0");
	ids=newArray(nImages);
	n=nImages;
	
	for (i=0;i<nImages;i++) {
		selectImage(i+1);
		title = getTitle;
		
		if (endsWith(title, "C0")){
			roiManager("open", ROIDir+list2[g]);
			array1 = newArray("0");
			for (ii=1;ii<roiManager("count");ii++){
				array1 = Array.concat(array1,ii);
				}
			
			roiManager("select", array1);
			roiManager("Multi Measure");
			selectWindow("Results");
			saveAs("Measurements", SaveDir+ch1name +"-C1Results.csv");
			run("Clear Results");
			}
			
			while (nImages>0) {
				selectImage(nImages);
				close();
				}
			}
		}