function PeakFiltering = detector(file) 

  %%%%% Loading data %%%%%%
  FileHandle = load(file);
  input = FileHandle.val(1, :);
  %%%%%%%%%%%%%%%%%%%%%%%%%

  %%%% Parameters %%%%
  Alpha = 0.0385; 
  Gamma = 0.16;
  MovingAverageWindow = 5; 
  SumInterval = 10; 
  Step = 180; 
  %%%%%%%%%%%%%%%%%%%%
  
  figure();
  plot(input(1 : length(input) / 100));
  hold on;
  
  %%%%%%%%% High-Pass Filtering %%%%%%%%%%%%%%%%%%%%%%
  input_len = length(input);
  Vec = zeros(1, input_len);
  for n = MovingAverageWindow : input_len
    Vec1 = 0;
    for m = 0 : (MovingAverageWindow - 1)      
        Vec1 = Vec1 + input(n - m);
    end % of inner for loop
    Vec1 = Vec1 / MovingAverageWindow;
    Vec2 = input(n - ((MovingAverageWindow + 1) / 2));
    Vec(n) = Vec2- Vec1;
  end % of outer for loop
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The first two lines of code calculate the length of input and initialize a vector Vec of zeros with the same length.
% Then, an outer loop iterates over the elements of Vec starting at the index MovingAverageWindow and ending at the last element of Vec.
% Inside the outer loop, the Vec1 variable is initialized to zero and another loop is used to calculate the moving average of the input values in the current window. 
% The inner loop iterates over a range of values from 0 to MovingAverageWindow - 1 and uses these values to index into input and sum the values. 
% The result is divided by MovingAverageWindow to calculate the average, and the result is stored in Vec1.
% Next, the central value of the current window is calculated by using the index n - ((MovingAverageWindow + 1) / 2) to index into input, and the result is stored in Vec2.
% Finally, the difference between Vec2 and Vec1 is calculated and stored in the corresponding element of Vec.
% Overall, this code is calculating the difference between the moving average and the central value of a window of size MovingAverageWindow for the input vector input and storing the result in the vector Vec.

  figure();
  plot(input(1 : length(input) / 100));
  hold on;
  
  %%%%%%%%%%%%% Low-Pass Filtering (non-L) %%%%%%%%%%%%
  input_sq = zeros(1, input_len);
  for i = 1 : input_len
    input_sq(i) = Vec(i) ^ 2;
  end % of for loop

  Vec = zeros(1, input_len);
  for n = SumInterval : input_len 
    for m = 0 : SumInterval - 1
       Vec(n) = Vec(n) + input_sq(n - m); 
    end % of inner for loop
  end % of outer for loop
  Vec_len = length(Vec);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This code is calculating the sum of squares for a given input vector Vec.
% The input_sq vector is initialized to zeros and then each element of Vec is squared and stored in the corresponding element of input_sq.
% Next, the Vec vector is also initialized to zeros and a nested loop is used to calculate the sum of squares.
% The outer loop iterates over the elements of Vec starting at the index SumInterval and ending at the last element of Vec.
% The inner loop iterates over a range of values from 0 to SumInterval - 1 and uses these values to index into input_sq and sum the squared values.
% The result is stored in the corresponding element of Vec.
% Finally, the length of the Vec vector is calculated and stored in Vec_len. 
% Overall, this code is calculating the sum of squares for the input vector Vec and storing the result in the vector Vec.

  figure();
  plot(Vec(1 : Vec_len / 100));
  hold off;
  
  %%%%%%%%%%% Decision %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Threshold = max(Vec(1 : Step));
  for i = 1 : Step : Vec_len
      window_end = min(i + Step, Vec_len);
      [Peak, IndexOfPeak] = max(Vec(i : window_end));
      if Peak >= Threshold
          Vec(IndexOfPeak + i) = - Inf;        
          Threshold = Alpha * Gamma * Peak + (1 - Alpha) * Threshold;
      end % of inner if statement
  end % of for loop
  PeakFiltering = find(Vec == - Inf);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The first line of code calculates the maximum value of Vec in the first Step elements and assigns the result to the Threshold variable. 
% This threshold value is used to determine if a peak is present in the current window of Vec.
% Next, a loop iterates over the elements of Vec starting at the first element and proceeding in steps of size Step. 
% For each iteration, the window_end variable is calculated as the minimum of i + Step and the length of Vec. This is used to determine the end of the current window of Vec.
% Inside the loop, the maximum value and its index in the current window of Vec are calculated using the max function. 
% If this maximum value is greater than or equal to the Threshold value, it is considered a peak and the corresponding element of Vec is set to -Inf. This effectively removes the peak from the input vector.
% The Threshold value is then updated using the Alpha, Gamma, and Peak values. Finally, the PeakFiltering variable is assigned the indices of Vec where the value is -Inf,
% which corresponds to the locations of the detected and filtered peaks in the input vector.
% Overall, this code is implementing a peak detection and filtering algorithm on the input vector Vec and storing the indices of the detected and filtered peaks in the PeakFiltering variable.

end % of function
