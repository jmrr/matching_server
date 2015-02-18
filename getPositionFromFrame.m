function relativePosition = getPositionFromFrame(frame)

gt = csvread('ground_truth_C2_P5.csv',1,1);

relativePosition = gt(frame)/gt(end);

end