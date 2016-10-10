close all;
clear;
clc;

im = imread('1.jpg');
im = rgb2gray(im);
im = imsharpen(im);
BW = edge(im,'Canny',0.1);
imshow(BW);