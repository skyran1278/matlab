clc; clear; close all;

generate_max('El_Centro_ALL')
generate_max('TCU068_EW_ALL')
generate_max('TCU068_NS_ALL')


function [] = generate_max(filename)

    A_2F = filename_to_array(filename, 10, 2, 17) * 100;
    V_2F = filename_to_array(filename, 10, 3, 17) * 100;
    D_2F = filename_to_array(filename, 10, 4, 17) * 100;
    A_3F = filename_to_array(filename, 10, 5, 17) * 100;
    V_3F = filename_to_array(filename, 10, 6, 17) * 100;
    D_3F = filename_to_array(filename, 10, 7, 17) * 100;
    A_RF = filename_to_array(filename, 10, 8, 17) * 100;
    V_RF = filename_to_array(filename, 10, 9, 17) * 100;
    D_RF = filename_to_array(filename, 10, 10, 17) * 100;

    A_2F_nodamper = filename_to_array((filename + "_nodamper"), 10, 2, 17) * 100;
    V_2F_nodamper = filename_to_array((filename + "_nodamper"), 10, 3, 17) * 100;
    D_2F_nodamper = filename_to_array((filename + "_nodamper"), 10, 4, 17) * 100;
    A_3F_nodamper = filename_to_array((filename + "_nodamper"), 10, 5, 17) * 100;
    V_3F_nodamper = filename_to_array((filename + "_nodamper"), 10, 6, 17) * 100;
    D_3F_nodamper = filename_to_array((filename + "_nodamper"), 10, 7, 17) * 100;
    A_RF_nodamper = filename_to_array((filename + "_nodamper"), 10, 8, 17) * 100;
    V_RF_nodamper = filename_to_array((filename + "_nodamper"), 10, 9, 17) * 100;
    D_RF_nodamper = filename_to_array((filename + "_nodamper"), 10, 10, 17) * 100;

    fprintf('%.3f %.3f %.3f %d %.3f %.3f %.3f %d %.3f %.3f %.3f\n', max(D_RF_nodamper), max(V_RF_nodamper), max(A_RF_nodamper), 1, max(D_RF), max(V_RF), max(A_RF), 1, max(D_RF) / max(D_RF_nodamper), max(V_RF) / max(V_RF_nodamper), max(A_RF) / max(A_RF_nodamper));
    fprintf('%.3f %.3f %.3f %d %.3f %.3f %.3f %d %.3f %.3f %.3f\n', max(D_3F_nodamper), max(V_3F_nodamper), max(A_3F_nodamper), 1, max(D_3F), max(V_3F), max(A_3F), 1, max(D_3F) / max(D_3F_nodamper), max(V_3F) / max(V_3F_nodamper), max(A_3F) / max(A_3F_nodamper));
    fprintf('%.3f %.3f %.3f %d %.3f %.3f %.3f %d %.3f %.3f %.3f\n', max(D_2F_nodamper), max(V_2F_nodamper), max(A_2F_nodamper), 1, max(D_2F), max(V_2F), max(A_2F), 1, max(D_2F) / max(D_2F_nodamper), max(V_2F) / max(V_2F_nodamper), max(A_2F) / max(A_2F_nodamper));

end
