k = [6023.0224 0; 0 108073.3891];
modeShape = [0.6180 -1.6180; 1 1];

inv(modeShape') * k * inv(modeShape)
