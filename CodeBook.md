CodeBook
==========
The data set is as below:
subject activity       sensor    statFUN axis     average
1   	LAYING     fBodyAcc     mean()    X -0.93909905
1   	LAYING     fBodyAcc     mean()    Y -0.86706521
1   	LAYING     fBodyAcc     mean()    Z -0.88266688
1   	LAYING     fBodyAcc meanFreq()    X -0.15879267
1   	LAYING     fBodyAcc meanFreq()    Y  0.09753484


subject describe 30 persons in this experiment. The value is from 1 to 30

activity describe the activity of each person.

sensor describe which sensor the signal comes from.

statFUN describe the stat function applied for the observation.

axis describe the the axis of the observation come from. It can be NA if the observation has nothing to do with the axis.

average is the value of the observation. It is the mean of the group subject and activity of the original data.

