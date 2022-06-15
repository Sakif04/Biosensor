clc;
clear all;
close all;
%% variables
file='videos\light_secondary\8mM13jun.mp4';
cropped_part=[555 1358 200 30];
 rotation_angle=90;
 pixel_no=89;
 brightness=145;

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

  %% cropping 
  croppedImage=imcrop(rotated_img,cropped_part);  
  %% Find the avg 
  avg=mean(croppedImage,1);
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

%% plot Distance VS Time Graph
figure;
plot(t,distance_mm);
xlabel('Time (s)');
ylabel('d (mm)');

%% plot Distance VS frame Graph
% figure;
% plot(frames,distance_mm);
%% Write to excel

% tim= table(t,distance_mm);
% filename = 'data.xlsx';
% xlswrite(filename,data,'Output','F1');


