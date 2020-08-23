// Enter desired min/max values below to edit LUT of each channel.

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

		}



	run("Merge Channels...", "c1=C1 c2=C0 create keep");

	selectWindow("Composite");
	
	saveAs("TIFF", SaveDir + no_channel_name + "_composite");	

	while (nImages>0) {

		selectImage(nImages);

		close();

		}

	}