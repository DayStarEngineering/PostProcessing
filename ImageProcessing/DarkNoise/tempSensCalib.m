% temperature calibration for Nick

clc; clear all; close all;

%% Load data
info = xlsread('NoiseExp.xlsx','Sheet2');
Vtop        = info(1:24,1);
Vbott       = info(1:24,2);
tempCtop    = info(1:24,3);
tempCbott   = tempCtop - 1.4*ones(24,1); % bottom was around 1.4C less than top

%% plotting

figure
plot(tempCtop,Vtop)
hold on
plot(tempCbott,Vbott,'r')

top = polyfit(tempCtop,Vtop,1)
topLine = top(1).*tempCtop+top(2);
plot(tempCtop,topLine)

bott = polyfit(tempCbott,Vbott,1)
bottLine = bott(1).*tempCbott+bott(2);
plot(tempCbott,bottLine,'r')
