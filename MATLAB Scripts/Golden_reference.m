%Golden Model Script : contains different angles within the range 
% -2*pi : 4*pi , and their sines and cosines 
n_digit_angles = 16 ; %Number of digits "integer and fractional"
n_digit_output = 16 ;
i = 5  ; %integer Part 
f = 11 ; %Fraction Part
n_stimulus = 50 ; %Number of Stimulus 
SF = 2^f ; %Scaling Factor

%Corner Angles

%Positive
corner_angles_positive = [0 , 90 , 180 , 270 , 360];
corner_angles_radian_pos = (pi/180).*corner_angles_positive ;
corner_angles_positive_str = dec2bin(round(SF.*corner_angles_radian_pos),n_digit_angles);

%Negative
corner_angles_radian_neg = (pi/180).*(-1.*corner_angles_positive) ;
corner_angles_negative_str = dec2bin(round(SF.*corner_angles_radian_neg),n_digit_angles);

%Random Angles
min = -2*pi ;
max = 4*pi ;
angles_radian = min + (max-min).*rand(50,1);
angles_radian_str = dec2bin(round(SF.*angles_radian),n_digit_angles);

%Boundary conditions of fixed-point representation 
max_fixed_point = 4*pi ;
max_fixed_point_str = dec2bin(round(max_fixed_point*SF),n_digit_angles);

%files : 
fileID_angles = fopen("angles.txt",'w');

for o = 1:1:5
    fprintf(fileID_angles,"%s\n",corner_angles_positive_str(o,1:n_digit_angles));
end

for o = 1:1:5
    fprintf(fileID_angles,"%s\n",corner_angles_negative_str(o,1:n_digit_angles));
end

for o = 1:1:50
    fprintf(fileID_angles,"%s\n",angles_radian_str(o,1:n_digit_angles));
end


fprintf(fileID_angles,"%s\n",max_fixed_point_str);

fclose(fileID_angles);

fileID_results_sine = fopen("results_sine.txt",'w');
fileID_results_cosine = fopen("results_cosine.txt",'w');

for index = 1:1:5
    [sine , cosine] = CORDIC_Rotation_mode(corner_angles_radian_pos(index));

    sine_str = dec2bin(round(sine*SF),n_digit_output);
    cosine_str = dec2bin(round(cosine*SF),n_digit_output);

    fprintf(fileID_results_sine,"%s\n",sine_str);
    fprintf(fileID_results_cosine,"%s\n",cosine_str);
end

for index = 1:1:5
    [sine , cosine] = CORDIC_Rotation_mode(corner_angles_radian_neg(index));

    sine_str = dec2bin(round(sine*SF),n_digit_output);
    cosine_str = dec2bin(round(cosine*SF),n_digit_output);

    fprintf(fileID_results_sine,"%s\n",sine_str);
    fprintf(fileID_results_cosine,"%s\n",cosine_str);
end

for index = 1:1:n_stimulus
    [sine , cosine] = CORDIC_Rotation_mode(angles_radian(index));

    sine_str = dec2bin(round(sine*SF),n_digit_output);
    cosine_str = dec2bin(round(cosine*SF),n_digit_output);

    fprintf(fileID_results_sine,"%s\n",sine_str);
    fprintf(fileID_results_cosine,"%s\n",cosine_str);
end

[sine , cosine] = CORDIC_Rotation_mode(max_fixed_point);

sine_str = dec2bin(round(sine*SF),n_digit_output);
cosine_str = dec2bin(round(cosine*SF),n_digit_output);

fprintf(fileID_results_sine,"%s\n",sine_str);
fprintf(fileID_results_cosine,"%s\n",cosine_str);

fclose(fileID_results_cosine);
fclose(fileID_results_sine);