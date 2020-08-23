run("Auto Threshold", "method=Default white");
setOption("BlackBackground", true);
run("Make Binary");
run("Dilate");
run("Close-");
run("Set Measurements...", "area mean min feret's redirect=None decimal=3");
run("Create Selection");
roiManager("Add");
roiManager("Multi Measure");