//for all the images in the directory

import gab.opencv.*;
import processing.video.*;
import java.awt.*;

void setup() {
  //load an image
  OpenCV opencv = new OpenCV(this, "../images/1.1330011.1363625255.jpg");
  PImage original = loadImage("../images/1.1330011.1363625255.jpg");
  size(opencv.width, opencv.height);

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
  //  image(opencv.getOutput(), 0, 0);
  image(original, 0, 0);
  //  noFill();
  fill(#fbe646);
  noStroke();
  //  stroke(0, 255, 0);
  //  strokeWeight(3);
  //look for faces
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  for (int i = 0; i < faces.length; i++) {
//    println(faces[i].x + "," + faces[i].y);
//    ellipse(faces[i].x+faces[i].width/2, faces[i].y+faces[i].height/2, 10, 10);
//    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}







//save each face to a new directory with the same filename as the input file
//append a suffix for every face

//load metadata about the image from a database


//save a html snippet back into the database, or to a text file

