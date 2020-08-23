import os
from ij import IJ
from ij.plugin.frame import RoiManager
from ij.io import FileSaver
from ij.process import ImageStatistics as IS


working_dir = "/Users/morriso1/Documents/Current Imaging Analysis/Laconic_III_esgts_old_control_E1F1/BacSub50/Analysis/Posterior/Cellpose_from_BS100"
os.chdir(working_dir)

def single_label_to_ROIs(img_filename):
	imp = IJ.openImage(os.path.join(os.getcwd(),img_filename))
	imp.show()
	ip = imp.getProcessor()
	stats = IS.getStatistics(ip, IS.MIN_MAX, imp.getCalibration())
	
	rm = RoiManager.getInstance()
	
	if not rm:
		rm = RoiManager()
	
	rm.reset()
	for i in range(int(stats.min+1), int(stats.max+1)):
		IJ.run("Threshold...")
		IJ.setRawThreshold(imp, i, i, None)
		IJ.run(imp, "Create Selection", "")
		rm.addRoi(imp.getRoi())

	
	rm.runCommand("Save", os.path.join(os.getcwd(), img_filename.replace(".tiff",".zip")))
	imp.close()

for files in sorted(os.listdir(os.getcwd())):
	single_label_to_ROIs(files)
		