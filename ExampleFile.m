functions = DesignFunctions;

% Example function use
input1 = 1;
input2 = 2;
[returnStatement1, returnStatement2] = functions.exampleFunction(input1, input2)

% Using Caleb's function
prompt = 'Enter input gear radius: ';
gearRadius = input(prompt);

[a, CR] = functions.gearRadiusToContactRatio(gearRadius);

fprintf('a = %f\n', a)
fprintf('CR = %f\n', CR)
