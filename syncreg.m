% Data Analysis of Synchronous Motor
% Data Set Information:
% Synchronous machine data were obtained in real time from the experimental
% operating environment.
% Attribute Information:

  % Iy (Load Current)
  % PF (Power factor)
  % e (Power factor error)
  % dIf (Changing of excitation current of synchronous machine)
  % If (Excitation current of synchronous machine)

 ###############################################################################
 % Read data from csv file_in_loadpath
 da = csvread("synchronous_machine.csv");
 das = da(2:end, 2:end);

 ###############################################################################
 % DATASET OVERVIEW AND STATISTICS
 [nr, nc] = size(das);
 fprintf("Shape of dataset: rows = %d and columns = %d \n", nr, nc)
 items_count = numel(das); % Total number of data observations
 fprintf("Total items in dataset: %d \n", items_count)

 tabs2 = dataframe(das);

 % Rename columns
 tabs2.colnames(1) = "Iy";
 tabs2.colnames(2) = "PF";
 tabs2.colnames(3) = "e";
 tabs2.colnames(4) = "dIF";
 tabs2.colnames(5) = "If";

 tabs2
 summary(tabs2)

 ###############################################################################
 %% DATA CLEANING
 % Checking for null values
 missing_data = sum((isnan(tabs2)));
 missing_data


 % Data Normalization
 dass = normalizedata(das);

 % Visualize Scatter Plot
 scatterPlot(dass(:,1:(nc-1)), dass(:,nc))

 ###############################################################################
 %% TRAINING
 % Split Data into Training and Testsing Sets
 X_train = [ones(round(0.7*nr),1) dass(1:round(0.7*nr),1:(nc-1))] ;
 y_train = (dass(1:round(0.7*nr),nc));

 % Compute Parametrs Normally
 theta = (inv((X_train .') * (X_train))) * (X_train .') * y_train

% Prediction
nr_p = round(0.7*nr) + 1; % Test data index
X_test = [ones((nr - nr_p), 1) dass(nr_p:(nr - 1), 1:(nc -1))];
y_test = dass(nr_p:(nr - 1), nc);
y_pred = (theta .') * (X_test .');

% Plot Prediction Against Measurement
xx = (1:(nr - nr_p)) .';
figure
hold on

c1 = plot(xx, y_test)
c2 = plot(xx, y_pred .')
set(c1, "linestyle", "-", "linewidth", 5, "marker", "*", "color", "r");
set(c2, "linestyle", "--", "linewidth", 5, "marker", "o", "color", "b");

xlabel("items", "fontsize", 20)
ylabel("Excitation Current (A)", "fontsize", 20)
c4 = title("Normal LR")
c3 = legend("Measurement", "Prediction");
set(c3, "FontSize", 15)
set(c4, "FontSize", 25)
hold off

% Compute Accuracy
MSE = (1/nr) * sum((y_pred .' - y_test) .^2);
RMSE = sqrt(((1/nr) * sum((y_pred .' - y_test) .^2)));
MAE = (1/nr) * sum(abs((y_pred .' - y_test)));

fprintf("MSE: %d \n", MSE);
fprintf("RMSE: %d \n", RMSE);
fprintf("MAE: %d \n", MAE);


