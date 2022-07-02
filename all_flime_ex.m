clc;
clear all;
close all;
%% variables
file='videos\light_secondary\8mM13jun.mp4';
cropped_part=[524 1080 350 35];
 rotation_angle=90;
 pixel_no=89;
 brightness=210;

%% Empty array to store distance and times
frame_start=50;
t=[];
frames=[];
distance_mm=[];

%% Load the video
x=VideoReader(file);
last_frame=x.NumberOfFrames;
frame_rate=x.FrameRate;
start_time=frame_start/frame_rate;
for frame= frame_start:50:last_frame;
  frames=[frames frame;];
  img=read(x,frame);
  
  %% gray conversion & rotation
  gray_img=rgb2gray(img);
  rotated_img=imrotate(gray_img,rotation_angle); %rotated image
  t=[t frame/frame_rate-start_time;]; 

  %% cropping & normalize the scale to 255
  croppedImage=imcrop(rotated_img,cropped_part); 
  ref_pixel=double(croppedImage(floor(size(croppedImage,1)/2),end));
  croppedImage=double(croppedImage);
  cropped=floor(croppedImage*(255/ref_pixel));
  
  %% Find the avg using mean function
  avg=mean(cropped,1);
  %% find the index of brightest pixel 
  p=find(avg>brightness);
  if isempty(p)
   temp_dist=0;   
  else
    temp_dist=p(1)*10/pixel_no;
  end
  distance_mm=[distance_mm temp_dist;];
end

t=transpose(t);
distance_mm=transpose(distance_mm);
[time,distance]=shift_sig(t,distance_mm);

%% plot Distance VS Time Graph
figure;
plot(time,distance);
xlabel('Time (s)');
ylabel('d (mm)');

%% plot Distance VS frame Graph
% figure;
% plot(frames,distance_mm);

%% Write to excel
% filename = 'mM_data.xlsx';
% xlswrite(filename,time,'8mM','I1');
