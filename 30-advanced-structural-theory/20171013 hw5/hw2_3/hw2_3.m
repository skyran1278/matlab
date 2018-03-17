% R06521217 乃宥然 高結HW2_3

% 消除前一次作業
clc; clear; close all;

% for loop method

tic;
printProbability(100, @bigTest);
printProbability(10000, @bigTest);
printProbability(1000000, @bigTest);
forLoopTime = toc;


% matrix method
fprintf('\n\n-------------------\nmatrix method contrast:\n\n');

tic;
printProbability(100, @bigTestByMatrixMethod);
printProbability(10000, @bigTestByMatrixMethod);
printProbability(1000000, @bigTestByMatrixMethod);
matrixTime = toc;

fprintf('\nmatrix method is faster than for loop method: %f times\n', forLoopTime / matrixTime);


function f = printProbability(testTimes, callback)
  fprintf('after %d tests, probability of failure is %f \n', testTimes, callback(testTimes));
end


function probability = bigTest(testTimes)
%bigTest - probability of failure
%
% Syntax: probability = bigTest(testTimes)
%
% Long probability of failure

  exceedLimitTimes = 0;

  for index = 1 : testTimes

    L = 5;
    E = 7.7 * 10 ^ 6 + ( 0.1 * 10 ^ 6 * rand );
    I = 8 * 10 ^ (-4) + ( 2 * 10 ^ (-4) * rand );
    w = 10 + 15 * rand;

    exceedLimit = 0.0069 * w * L ^ 4 / E / I > L / 360;

    if exceedLimit
      exceedLimitTimes = exceedLimitTimes + 1;
    end

  end

  probability = exceedLimitTimes / testTimes;

end


function probability = bigTestByMatrixMethod(testTimes)
%bigTest - probability of failure
%
% Syntax: probability = bigTest(testTimes)
%
% Long probability of failure

  L = 5;
  E = 7.7 * 10 ^ 6 + ( 0.1 * 10 ^ 6 * rand(1, testTimes) );
  I = 8 * 10 ^ (-4) + ( 2 * 10 ^ (-4) * rand(1, testTimes) );
  w = 10 + 15 * rand(1, testTimes);

  exceedLimitTimes = sum(sum(0.0069 .* w .* L .^ 4 ./ E ./ I > L / 360));

  probability = exceedLimitTimes / testTimes;

end
