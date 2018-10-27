function data = FT_data

    disp('Welcome to our experiment!');
    data.nr = input('Subject number?: ');
    data.gender = input('Gender? (m/f): ', 's');
    data.handedness = input('Handedness? (l/r): ', 's');
    data.age = input('Age?: ');

end