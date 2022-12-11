%%%%% Executive Agent %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files = dir('./23*.mat');
for file = files'
  PerFileRes = detector(file.name);   
  wrann(file.name(1:end-5), 'qrs', PerFileRes);
  asci_name = sprintf('%s.asc', file.name(1:end-5)); 
  FileId = fopen(asci_name, 'wt');  
  for i = 1 : size(PerFileRes, 2)
      fprintf(FileId, '0:00:00.00 %d N 0 0 0\n', PerFileRes(1, i));
  end % of inner for loop 
  fclose(FileId);
end % of outer for loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%