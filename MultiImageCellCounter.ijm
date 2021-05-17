
// MICC is a simple ImageJ - Macro to count cells of multiple images at once.
// See https://github.com/not-a-feature/MultiImageCellCounter for more information
// Copyright (C) 2021 by Jules Kreuer - @not_a_feature
// This piece of software is published unter the GNU General Public License v3.0


run("Clear Results"); 
setBatchMode(true); 

// init default parameters
inputPath = "";
minSize = 100;
maxSize = 0;
minCirc = 0;
maxCirc = 1;
fillHoles = true
watershed = true;
exconEdges = false;
verbose = false;
channel = -1;
outputPath = "";

function processImage(imageFile, outputFile, minSize, maxSize, minCirc, maxCirc, fillHoles, watershed, exconEdges, channel) {
    if (verbose) {
        print("Opening file: " + imageFile);
    }
    open(imageFile);
    if(verbose) {
        print("Selecting channel..");
    }
    // Closing unused channels
    if (channel != -1){
        while (!endsWith(getTitle(), "Ch" + d2s(channel, 0))) {
            if (verbose) {
                print("Closing Channel " + getTitle());
            }
            close();
        }
    }

    filename = getTitle();
    if (verbose) {
        print("Selected Channel" + filename);
    }
    setAutoThreshold("Default dark");
    setOption("BlackBackground", false);
    run("Convert to Mask");
    run("Median...", "radius=17");
    if (fillHoles) {
        run("Fill Holes");
    }
    if (watershed) {
        run("Watershed");
    }
    // Cell Size from min to max
    if (maxSize == 0) {
        size = d2s(minSize, 0) + "-Infinity";
    }
    else {
        size = d2s(minSize, 0) + "-" + d2s(maxSize, 0);

    }
    circularity = d2s(minCirc, 2) + "-" + d2s(maxCirc, 2);
    if (exconEdges) {
        show = "[Overlay Masks] display exclude summarize";
    }
    else {
        show = "[Overlay Masks] display summarize";
    }
    run("Analyze Particles...", "size=" + size + " circularity=" + circularity + " show=" + show);
    if (!(outputFile == "")) {
        if (verbose) {
            print("Saving as " + outputFile);
        }
        saveAs("png", outputFile);
    }
    close("*");
}


correctInput = false;
while (!correctInput) {
    // Get user input
    setFont("Monospaced", 12);
    Dialog.create("Cell Counting");
    Dialog.addMessage("Count the cells in multiple images. Please specify following parametes.");
    Dialog.addMessage("");
    Dialog.addDirectory("Path to folder: ", inputPath);
    Dialog.addSlider("Minimum cell size", 0, 10000, minSize);
    Dialog.addSlider("Maximum cell size", 00, 50000, maxSize);
    Dialog.addToSameRow()
    Dialog.addMessage("[Set to 0 for no upper limit]")
    Dialog.addSlider("Minimum cell circularity", 0, 100, minCirc*100);
    Dialog.addSlider("Maximum cell circularity", 0, 100, maxCirc*100);
    Dialog.addMessage("------------------------------------------------------------------------------------------------------------------------\nAdvanced:");
    Dialog.addCheckbox("Fill holes", fillHoles);
    Dialog.addCheckbox("Watershed", watershed);
    Dialog.addCheckbox("Exclude on edges", exconEdges);
    Dialog.addCheckbox("Verbose", verbose);
    Dialog.addNumber("Channel", channel);
    Dialog.addToSameRow()
    Dialog.addMessage("[-1 if file has only one channel]")
    Dialog.addDirectory("Output files directory", outputPath);
    Dialog.addMessage("\n\n\n");
    Dialog.addMessage("------------------------------------------------------------------------------------------------------------------------\nLICENSE:\nCopyright (c) 2021 by Jules Kreuer - @not_a_feature\nThis piece of software is published unter the GNU General Public License v3.0");
    Dialog.addMessage(" Permissions          | Conditions                              | Limitations \n -------------------------------------------------------------------------------------------------- \n + Commercial use | Disclose source                      | - Liability \n + Distribution        | License and copyright notice | - Warranty  \n + Modification       | Same license                          |             \n + Patent use        | State changes                        |             \n + Private use        |");
    Dialog.addMessage("This progamm was written for ImageJ 1 but should also work in ImageJ 2.");
    Dialog.addMessage("For more information see: https://github.com/not-a-feature/MultiImageCellCounter");
    Dialog.show();

    inputPath  = Dialog.getString();
    minSize    = Dialog.getNumber();
    maxSize    = Dialog.getNumber();
    minCirc    = Dialog.getNumber()/100;
    maxCirc    = Dialog.getNumber()/100;
    fillHoles  = Dialog.getCheckbox();
    watershed  = Dialog.getCheckbox();
    exconEdges = Dialog.getCheckbox();
    verbose    = Dialog.getCheckbox();
    channel    = Dialog.getNumber();
    outputPath = Dialog.getString();

    // Check if user input is valid
    if (!File.isDirectory(inputPath)) {
        waitForUser("Error!\nPlease check your input path.");
    }
    else if (!(outputPath == "")) {
        if (!File.isDirectory(outputPath)) {
            waitForUser("Error!\nPlease check your output path.");
        }
        else {
            correctInput = true;
        }
    }
    else {
        correctInput = true;
    }

}
fileList = getFileList(inputPath);
if (fileList.length == 0) {
    waitForUser("Attention! The selected input folder is empty.");
}
// Process every file
for (i = 0; i < fileList.length; i++) {
    outputFile = "";
    if (!(outputPath == "")) {
        outputFile = outputPath + fileList[i] + "_counted.png";
    } 
    processImage(inputPath + fileList[i], outputFile, minSize, maxSize, minCirc, maxCirc, fillHoles, watershed, exconEdges, channel);
}
waitForUser("Done! You can now inspect the summary.");
