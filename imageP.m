clc;
clear all;
close all;

%% Variables
 file='E:\Biosensor\video_extraction\videos\8mM_Exp2.mp4';
 cropped_part=[250 615 300 15];
 rotation_angle=88;
 pixel_no=75;
 brightness=156;
 
  %% Load the video on a variable
  x=VideoReader(file);
  %% Frame Select
 last_frame=x.NumberOfFrames;
 frame_number=500;
 
  %% Select a frame number that we want to analyze
  img=read(x,frame_number);
  img2=read(x,501);
  %% Gray Conversion & rotation
  rotated_img=imrotate(img,rotation_angle);
  figure;
  imshow(rotated_img)
  %% Rotated image
  gray_img=rgb2gray(rotated_img);
  
 
  %% Cropped image 
  figure;
  imshow(imcrop(rotated_img,cropped_part));
  %%cropped_part is selected in such way using a matrix
  %%where [x1,y1,width,hieght] x1=initial
  %%horizontal position and y1=initial vertical position
  croppedImage=imcrop(gray_img,cropped_part);
  figure;
  imshow(croppedImage);
  ref_pixel=double(croppedImage(floor(size(croppedImage,1)/2),end));
  croppedImage=double(croppedImage);
  cropped=floor(croppedImage*(255/ref_pixel));
  %% Find the avg using mean function
  avg=mean(cropped,1);
  %% Select color intensity
  p=find(avg>=brightness);% find the index of brightest pixels_width
  if isempty(p);
    temp_dist=0;
  else
      temp_dist=p(1)*10/pixel_no;
  end
  %find the number of pixels in 10mm using the part of image containing scale
  distance_in_mm=temp_dist;
  distance_in_mm