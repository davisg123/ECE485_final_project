function [y] = noteFreq(note)

base = 2.^((0:12)/12);

two=110*base;
three=220*base;
four=440*base;
five=880*base;
six=1760*base;
seven=3520*base;

twoStrings={'A2';'A#2/Bb2';'B2';'C3';'C#3/Db3';'D3';'D#3/Eb3';'E3';...
    'F3';'F#3/Gb3';'G3';'G#3/Ab3'};
threeStrings={'A3';'A#3/Bb3';'B3';'C4';'C#4/Db4';'D4';'D#4/Eb4';'E4';...
    'F4';'F#4/Gb4';'G4';'G#4/Ab4'};
fourStrings={'A4';'A#4/Bb4';'B4';'C5';'C#5/Db5';'D5';'D#5/Eb5';'E5';...
    'F5';'F#5/Gb5';'G5';'G#5/Ab5'};
fiveStrings={'A5';'A#5/Bb5';'B5';'C6';'C#6/Db6';'D6';'D#6/Eb6';'E6';...
    'F6';'F#6/Gb6';'G6';'G#6/Ab6'};
sixStrings={'A6';'A#6/Bb6';'B6';'C7';'C#7/Db7';'D7';'D#7/Eb7';'E7';...
    'F7';'F#7/Gb7';'G7';'G#7/Ab7'};
sevenStrings={'A7';'A#7/Bb7';'B7';'C8';'C#8/Db8';'D8';'D#8/Eb8';'E8';...
    'F8';'F#8/Gb8';'G8';'G#8/Ab8'};

allMajors = [two;three;four;five;six;seven];
allStrings = [twoStrings;threeStrings;fourStrings;fiveStrings...
    ;sixStrings;sevenStrings];

matchGrid = strfind(allStrings,note);
matchGridSize = size(matchGrid);
match = 0;

for i=1:matchGridSize(1)
    if ~isempty(matchGrid{i,1})
        match = i;
    end
end

majorMatch = ceil(match/12);
innerMajorMatch = rem(match,12);

finalMajor = allMajors(majorMatch,:);

y = finalMajor(innerMajorMatch);
