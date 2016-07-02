function [assignments] = lapjv_old(costMatrix)

inputFileName = 'temp_input';
outputFileName = 'temp_output';

writeMatrixToBinaryFile(costMatrix,inputFileName);

[status shellText] = unix(['./linAssignBinFile ' inputFileName ' ./' outputFileName]);
if status ~= 0
  error(shellText);
end

load(['./' outputFileName]);
eval(['assignments = ' outputFileName ';']);
delete(inputFileName);
delete(outputFileName);

assignments = assignments + 1;
assignments = assignments';
