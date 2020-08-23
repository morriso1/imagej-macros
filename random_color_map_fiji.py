from ij import IJ
from ij.plugin.frame import RoiManager
from ij.io import FileSaver
import os


def ROIs_to_multicolor_images(image_dir, roi_dir, save_dir, file_ext=".tiff"):

    rm = RoiManager.getInstance()
    if not rm:
        rm = RoiManager()
    rm.reset()

    image_dir = os.path.join(os.getcwd(), image_dir)
    if not os.path.isdir(image_dir):
        print "no directory for images"
        return

    roi_dir = os.path.join(os.getcwd(), roi_dir)
    if not os.path.isdir(roi_dir):
        print "no directory for images"
        return

    save_dir = os.path.join(os.getcwd(), save_dir)
    if not os.path.isdir(save_dir):
        os.mkdir(save_dir)

    for i, filename in enumerate(os.listdir(image_dir)):
        if filename.endswith(file_ext):
            print "Processing", filename
            imp = IJ.openImage(os.path.join(image_dir, filename))
            rm.runCommand("Open", os.path.join(roi_dir, filename + ".zip"))
            result = IJ.createImage(
                "Labelling", "16-bit black", imp.getWidth(), imp.getHeight(), 1)
            ip = result.getProcessor()

            for index, roi in enumerate(rm.getRoisAsArray()):
                ip.setColor(index+1)
                ip.fill(roi)

            ip.resetMinAndMax()
            IJ.run(result, "glasbey inverted", "")
            IJ.run(result, "8-bit", "")
            fs = FileSaver(result)
            fs.saveAsTiff(os.path.join(save_dir, filename))
            rm.reset()


working_dir = "path_to_working_directory"
os.chdir(working_dir)

ROIs_to_multicolor_images("C1", "ROIs", "multi_color_masks")
