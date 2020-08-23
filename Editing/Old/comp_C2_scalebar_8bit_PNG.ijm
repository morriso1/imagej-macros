// This macro subtracts background on each channel, combines channels and saves as TIFFs.

// Enter desired min/max values below to edit LUT of each channel.

C0_min = 400;
C0_max = 4000;

C1_min = 600;
C1_max = 10000;

C0_max_proj = getDirectory("C0_folder");
C1_max_proj = getDirectory("C1_folder");
list = getFileList(C0_max_proj); // This lists all the files in C0 folder
SaveDir = getDirectory("This where composites will be saved"); // This is where composites are saved 

for (g=0; g<list.length; g++) { // This goes through each file in C0
	C0_name = list[g]; // This takes the name of the file and makes it a variable called C0_name
	C1_name = replace(C0_name, "C0", "C1"); // This generates C1name variable by replacing IDs. Choose a unique identifier in your images
	no_channel_name = replace(C0_name, "_C0.tiff", ""); // This generates name variable that lacks channel name

	if (File.exists(C1_max_proj + C1_name) && File.exists(C0_max_proj + C0_name)); { 
		print(C0_name);
		open(C0_max_proj + C0_name);
		rename ("C0"); 
		print(C1_name);
		open(C1_max_proj + C1_name);
		rename ("C1");

		ids=newArray(nImages); //checks how many images are currently open
		n=nImages;
		
		for (i=0;i<nImages;i++) {
			selectImage(i+1);
			title = getTitle;

			if (endsWith(title, "C0")){
				run("Brightness/Contrast...");
				setMinAndMax(C0_min, C0_max);
				}

			if (endsWith(title, "C1")){
				run("Brightness/Contrast...");
				setMinAndMax(C1_min, C1_max);
				}
				}
			}

	run("Merge Channels...", "c1=C1 c2=C0 create keep");
	selectWindow("Composite");
	run("8-bit");
	run("Scale Bar...", "width=20 height=6 font=18 color=White background=None location=[Lower Right] bold overlay label");
	saveAs("PNG", SaveDir + no_channel_name + " composite" + C0_min + C0_max + C1_min + C1_max); // saves composite
	
	while (nImages>0) {
		selectImage(nImages);
		close();
		}
	}
