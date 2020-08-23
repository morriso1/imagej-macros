run("Auto Threshold", "method=RenyiEntropy white");
setOption("BlackBackground", true);
run("Make Binary");
run("Erode");
run("Watershed");
run("Analyze Particles...", "size=10-Infinity clear add");