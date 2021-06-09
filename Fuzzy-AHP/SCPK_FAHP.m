namaSiswa = {'Andi' 'Bagus' 'Cinta'};
data = [95  95  80
        90  100 95
        90  90  70 ];
    
%maks kriteria

maksUsiaTanaman = 100;
maksKualitasTanaman = 100;
maksHarga = 100;

data(:,1) = data(:,1) / maksUsiaTanaman;
data(:,2) = data(:,2) / maksKualitasTanaman;
data(:,3) = data(:,3) / maksHarga;


relasiAntarKriteria = [1    2   2
                       0    1   2
                       0    0   1];
                   
TFN = {[-100/3 0     100/3]     [3/100  0     -3/100]
       [0      100/3 200/3]     [3/200  3/100 0     ]
       [100/3  200/3 300/3]     [3/300  3/200 3/100 ]
       [200/3  300/3 400/3]     [3/400  3/300 3/200 ]};
   
[RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria)

if RasioKonsistensi < 0.10
    % Metode Fuzzy AHP
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN)    

    % Hitung nilai skor akhir
    ahp = data * bobotAntarKriteria';
    
    disp('Hasil Perhitungan dengan metode Fuzzy AHP')
    disp('Nama Karyawan, Skor Akhir, Kesimpulan')
end

for i = 1:size(ahp, 1)
        if ahp(i) < 0.6
            status = 'Kurang';
        elseif ahp(i) < 0.7
            status = 'Cukup';
            elseif ahp(i) < 0.8
            status = 'Baik';
        else
            status = 'Sangat Baik';
        end
        
        disp([char(namaKaryawan(i)), blanks(13 - cellfun('length',namaKaryawan(i))), ', ', ... 
             num2str(ahp(i)), blanks(10 - length(num2str(ahp(i)))), ', ', ...
             char(status)])
end

