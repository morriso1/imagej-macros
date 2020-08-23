dir1 = getDirectory("Select Directory with 16 bit TIFF files");
list = getFileList(dir1);
SaveDir = getDirectory("This is where 8 bit PNG files are to be saved");

for (g=0; g<list.length; g++) {
	ch1name = list[g];
	print(ch1name);
	open(dir1 + ch1name);

	run("8-bit");

	saveAs("PNG", SaveDir + ch1name);
	while (nImages>0) {
		selectImage(nImages);
		close();
	}
}
