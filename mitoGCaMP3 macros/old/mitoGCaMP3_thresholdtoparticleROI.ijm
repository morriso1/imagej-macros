run("Auto Threshold", "method=Default white");
setOption("BlackBackground", true);
run("Make Binary");
run("Dilate");
run("Close-");
run("Set Measurements...", "area mean min feret's redirect=None decimal=3");
roiManager("Deselect");
run("Analyze Particles...", "size=4-Infinity clear add");