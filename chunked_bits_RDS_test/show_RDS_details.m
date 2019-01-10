function show_RDS_details(type,PI,PTY,AF,N,text1,text2,Hour,Minutes,LocalTimeOffset, Y,M,D, PIN)

% Program Types Annex F , Table F.1
ProgTypes = {'None' 'News' 'Affairs' 'Info' 'Sport' 'Educate' 'Drama' 'Culture' 'Science' 'Varied' 'Pop M' ...
             'Rock M' 'Easy M' 'Light M' 'Classics' 'Other M' 'Weather' 'Finance' 'Children' 'Social' 'Religion' ...
             'Phone In' 'Travel' 'Leisure' 'Jazz' 'Country' 'Nation M' 'Oldies' 'Folk M' 'Document' 'TEST' 'Alarm!'};
if type(1:4) == [0 0 0 0]
    fprintf('\n');
    if type(5) == 0
        disp('Group 0A detected:');
        fprintf('PI : %s\nPTY : %s\n',  PI, ProgTypes{PTY+1});

        fprintf('Alternative frequences: ');
        for i=1:length(AF)
            fprintf('%0.1f ',AF(i));
        end
        fprintf('\n')
    else
        fprintf('\n');
        disp('Group 0B detected:');
    end
    
elseif type(1:4) == [0 0 0 1]
    fprintf('\n');
    if type(5) == 0
        disp('Group 1A detected:');
    else
        disp('Group 1B detected:');
    end
    frpintf('PIN: Day : %d, Hour : %2d:%2d\n\n',PIN(1),PIN(2),PIN(3));
    
elseif type(1:4) == [0 0 1 0]
    fprintf('\n');
    if type(5) == 0
        disp('Group 2A detected:');
    else
        disp('Group 2A detected:');
    end
    fprintf('Radio Text1 : %s\n', text1);
    fprintf('Radio Text2 : %s\n\n', text2);
    

elseif type(1:5) == [0 1 0 0 0]
    fprintf('\n');
    disp('Group 4A detected:');
    fprintf('Time : %2d:%2d + %dh\nDate : %2d.%2d.%d\n\n',Hour,Minutes,LocalTimeOffset,D,M,Y);
end