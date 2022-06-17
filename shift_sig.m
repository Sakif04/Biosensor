function [ time,distance ] = Shift_sig(tim,dist )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
indices=find(dist>= 0.12);
start_ind=indices(1)
start_time=tim(start_ind);
time=tim-start_time;
time=time(time>=0);
distance=dist(start_ind:end);
end

