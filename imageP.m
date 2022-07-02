clc;
clear all;
close all;
%% variables
file='videos\light_secondary\8mM13jun.mp4';
cropped_part=[524 1080 350 35];
 rotation_angle=90;
 pixel_no=89;
 brightness=210;
 
%%Frame Select
 frame_number=6200;
  %% Load the video on a variable
  x=VideoReader(file);
  
  %% Select a frame number that we want to analyze
  img=read(x,frame_number);
  img2=read(x,501);
  %% Gray Conversion & rotation
  rotated_img=imrotate(img,rotation_angle);
  figure;
  imshow(rotated_img)
  
  %% rotated image
  gray_img=rgb2gray(rotated_img);  

  %% Cropped image 
  figure;
  imshow(gray_img)
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
