% You can use this skeleton or write your own.
% You are __STRONGLY__ suggest to run this script section-by-section using Ctrl+Enter.
% See http://www.mathworks.cn/cn/help/matlab/matlab_prog/run-sections-of-programs.html for more details.

%%load data
load('data');
%cat(2, A, B)�൱��[A, B];
all_x = cat(2, x1_train, x1_test, x2_train, x2_test);
range = [min(all_x), max(all_x)];
train_x = get_x_distribution(x1_train, x2_train, range);
test_x = get_x_distribution(x1_test, x2_test, range);

%% Part1 likelihood: 
l = likelihood(train_x);
bar(range(1):range(2), l');
xlabel('x');
ylabel('P(x|\omega)');
axis([range(1) - 1, range(2) + 1, 0, 0.5]);
%TODO
%compute the number of all the misclassified x using maximum likelihood decision rule
wrongtestNum_part1 = misclassified(test_x, l);
testerror_part1 = wrongtestNum_part1/sum(sum(test_x));
fprintf('Through using maximum likehood rule, the number of misclassified test samples are %d.\n',wrongtestNum_part1);
fprintf('Maximum likehood rule''s test error is %d.\n',testerror_part1);

%% Part2 posterior:
p = posterior(train_x);
bar(range(1):range(2), p');
xlabel('x');
ylabel('P(\omega|x)');
axis([range(1) - 1, range(2) + 1, 0, 1.2]);
%TODO
%compute the number of all the misclassified x using optimal bayes decision rule
wrongtestNum_part2 = misclassified(test_x, p);
testerror_part2 = wrongtestNum_part2/sum(sum(test_x)); 
fprintf('Through using optimal bayes decision rule, the number of misclassified test samples are %d.\n',wrongtestNum_part2);
fprintf('Optimal Bayes decision rule''s test error is %d.\n',testerror_part2);

%% Part3 risk:
risk = [0, 1; 2, 0];
%TODO
%get the minimal risk using optimal bayes decision rule and risk weights
R1 = risk(1,1) * p(1,:) + risk(1,2) * p(2, :);
R2 = risk(2,1) * p(1,:) + risk(2,2) * p(2, :);
risk_min = sum( (R1<R2) .* R1 + (R1>R2) .* R2 );
fprintf('Optimal Bayes decision rule''s minimal is %d.\n',risk_min');