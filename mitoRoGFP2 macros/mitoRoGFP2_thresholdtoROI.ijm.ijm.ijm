run("Auto Threshold", "method=RenyiEntropy white");
run("Erode");
run("Set Measurements...", "area mean min redirect=None decimal=3");
run("Analyze Particles...", "size=5-Infinity display exclude add");
