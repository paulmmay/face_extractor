
/*

Face Extractor
Paul May
2014
 
Uses OpenCV for Processing (http://gregborenstein.com) to extract faces from images.

*/

import gab.opencv.*;
import processing.video.*;
import java.awt.*;

String images_dir = "images";
String faces_dir = "faces";

void setup() {
  File images_path = new File(sketchPath+"/"+images_dir);
  String image_names[] = images_dir.list();
  for (int i=0;i<image_names.length;i++) {
    println(images_dir+"/"+image_names[i]);
    String extension = image_names[i].substring(image_names[i].length()-4, image_names[i].length());
    if (extension.equals(".jpg")) {
      OpenCV opencv = new OpenCV(this, images_dir+"/"+image_names[i]);
      PImage original = loadImage(images_dir+"/"+image_names[i]);
      opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
      Rectangle[] faces = opencv.detect();
      for (int j = 0; j < faces.length; j++) {
        PImage new_image = original.get(faces[j].x, faces[j].y, faces[j].width, faces[j].height);
        //append a suffix for every face
        //save each face to a new directory with the same filename as the input file
        new_image.save(faces_dir+"/"+image_names[i].substring(0, image_names[i].length()-4)+"."+str(j)+".jpg");
      }
    }
  }
}
