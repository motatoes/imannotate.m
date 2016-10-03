INTRODUCTION
=============

This software is an annotation tool for marking annotations in images. This tool was developed to be able to mark some annotations in retinal images in order to be used as a groundtruth to evaluate some algorithms. The tool can generate binary masks after the annotation is done. The supported shapes by this tool are:

- circles
- ellipses
- rectangles
- points
- polygons
- lines

It is configurable and supports specifying the types of annotations depending on application, as well as specifying the shape for each annotation type. It also supports tagging capabilities for each annotation category and querying for subsets of the annotations using tags or categories.

![Samples](https://github.com/motatoes/imannotate.m/raw/develop/docs/images/sample.png)


The software is written in MATLAB and is currently only supported by MATLAB since the it writes to `.mat` files. However, support for open formats such as JSON and csv is planned in future releases.

