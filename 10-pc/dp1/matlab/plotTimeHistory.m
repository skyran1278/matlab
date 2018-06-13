clc; clear; close all;

time = filename_to_array('TCU067_NS_Artificial', 2, 1, 0);
data = filename_to_array('TCU067_NS_Artificial', 2, 2, 0);

plot(time, data);
