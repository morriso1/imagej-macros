// Enter desired min/max values below to edit LUT of each channel.

C0_min = 300;
C0_max = 6000;

C1_min = 400;
C1_max = 8000;

C0_max_proj = getDirectory("This where C0 files are stored");

C1_max_proj = getDirectory("This where C1 files are stored");

SaveDir = getDirectory("Choose a Directory"); 
list = getFileList(C0_max_proj); 

for (g=0; g<list.length; g++) { // This goes through each file in C0

	C0_name = list[g]; // This takes the name of the file and makes it a variable called ch1name

	C1_name = replace(C0_name, "C0", "C1"); // This generates C1 name variable by replacing IDs. Choose a unique identifier in your images

	no_channel_name = replace(C0_name, "_C0.tiff", ""); // This generates name variable that lacks channel name



	if (File.exists(C0_max_proj + C0_name) && File.exists(C1_max_proj + C1_name)); { 

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
				run("Blue");
				setMinAndMax(0, 65535);
				call("ij.ImagePlus.setDefault16bitRange", 16);
				setMinAndMax(C0_min, C0_max);
				call("ij.ImagePlus.setDefault16bitRange", 16);
				setOption("ScaleConversions", true);
				run("8-bit");
				}



			if (endsWith(title, "C1")){
				run("Green");
				setMinAndMax(0, 65535);
				call("ij.ImagePlus.setDefault16bitRange", 16);
				setMinAndMax(C1_min, C1_max);
				call("ij.ImagePlus.setDefault16bitRange", 16);
				setOption("ScaleConversions", true);
				run("8-bit");
				}

			}

		}



	run("Merge Channels...", "c1=C1 c2=C0 create keep");

	selectWindow("Composite");
	run("Scale Bar...", "width=20 height=8 font=18 color=White background=None location=[Lower Right] bold overlay label");
	run("RGB Color");
	saveAs("PNG", SaveDir + no_channel_name + "_composite");

	selectWindow("C0");
	saveAs("PNG", SaveDir + no_channel_name + "_LUTedit_C0");

	selectWindow("C1");
	saveAs("PNG", SaveDir + no_channel_name + "_LUTedit_C1");
	

	while (nImages>0) {

		selectImage(nImages);

		close();

		}

	}