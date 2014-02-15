
/*

 Face Extractor
 Paul May
 2014
 
 Uses OpenCV for Processing (http://gregborenstein.com) to extract faces from images.
 
 */

import gab.opencv.*;
import processing.video.*;
import java.awt.*;

String images_dir = "images"; //load .jpg images from directory (within current sketch folder).
String faces_dir = "faces"; //save faces to directory (within current sketch folder).
String data_dir = "data"; //save data about the faces here

void setup() {
  JSONObject all_face_data = new JSONObject();

  File images_path = new File(sketchPath+"/"+images_dir);
  String image_names[] = images_path.list();
  for (int i=0;i<image_names.length;i++) {
    String extension = image_names[i].substring(image_names[i].length()-4, image_names[i].length());
    if (extension.equals(".jpg")) {
      //create a snippet of json to describe faces in the original image?
      JSONArray image_faces = new JSONArray();
      OpenCV opencv = new OpenCV(this, images_dir+"/"+image_names[i]);
      PImage original = loadImage(images_dir+"/"+image_names[i]);
      opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
      Rectangle[] faces = opencv.detect();
      for (int j = 0; j < faces.length; j++) {
        PImage new_image = original.get(faces[j].x, faces[j].y, faces[j].width, faces[j].height);
        //append a suffix for every face
        //save each face to a new directory with the same filename as the input file
        String face_file_name = image_names[i].substring(0, image_names[i].length()-4)+"."+str(j)+".jpg";
        new_image.save(faces_dir+"/"+face_file_name);
        //save data about face locations
        JSONObject face_loc = new JSONObject();
        face_loc.setInt("x", faces[j].x);
        face_loc.setInt("y", faces[j].y);
        face_loc.setInt("w", faces[j].width);
        face_loc.setInt("h", faces[j].height);
        image_faces.setJSONObject(j, face_loc);
      }
      all_face_data.setJSONArray(image_names[i], image_faces);
    }
  }
  saveJSONObject(all_face_data, data_dir+"/"+"all_face_data.json");
}

