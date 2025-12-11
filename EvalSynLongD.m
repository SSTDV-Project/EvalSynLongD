% Linear mixed effect modeling of real and synthetic data 
% and evaluate statistical similarity with Cohen's d

%%% User defined variables
% data : 3 X n matrix
% 1st column : data id, 2nd column : time points, 3rd column : measurement
Rtable = readtable('RealLongData.xlsx'); % real longitudinal data 
Stable = readtable('SyntheticLongData.xlsx'); % synthetic longitudinal data
%%%%%%%%%%%%%%%%%%%
%%% For Real data
RealID = Rtable.Data_ID;
RealTimes = Rtable.Time;
RealY = Rtable.Measurement;
RealSubject = categorical(RealID);
RealGroup = ones(length(RealY),1);
D = dummyvar(RealGroup);
Z = [ones(size(RealY,1),1), RealTimes];
G = RealSubject;
X = [D(:,:), D(:,1).*RealTimes];
lme = fitlmematrix(X,RealY,Z,G,'FixedEffectPredictors',{'Intercept', 'Age'},...
    'RandomEffectPredictors',{{'Intercept','Age'}},'RandomEffectGroups',{'Subject'},...
    'DummyVarCoding', 'full', 'FitMethod', 'REML');
[Beta,BetaNames,BetaStats] = fixedEffects(lme);
[B, Bnames,BStats] = randomEffects(lme);
RInterceptDist = B(1:2:end);
RealInterceptDist = RInterceptDist+ Beta(1);
RSlopeDist = B(2:2:end);
RealSlopeDist = RSlopeDist + Beta(2);
% %%% For synthetic data %%%
SynID = Stable.Data_ID;
SynTimes = Stable.Time;
SynY = Stable.Measurement;
SynSubject = categorical(SynID);
SynGroup = ones(length(SynY),1);
D = dummyvar(SynGroup);
Z = [ones(size(SynY,1),1), SynTimes];
G = SynSubject;
X = [D(:,:), D(:,1).*SynTimes];
lme = fitlmematrix(X,SynY,Z,G,'FixedEffectPredictors',{'Intercept', 'Age'},...
    'RandomEffectPredictors',{{'Intercept','Age'}},'RandomEffectGroups',{'Subject'},...
    'DummyVarCoding', 'full', 'FitMethod', 'REML');
[Beta,BetaNames,BetaStats] = fixedEffects(lme);
[B, Bnames,BStats] = randomEffects(lme);
SInterceptDist = B(1:2:end);
SynInterceptDist = SInterceptDist+ Beta(1);
SSlopeDist = B(2:2:end);
SynSlopeDist = SSlopeDist + Beta(2);
%%% Cohen'd
data1 = RealSlopeDist; data2 = SynSlopeDist;
m1 = mean(data1); m2 = mean(data2);
SDpool = sqrt(((std(data1))^2)+(std(data2)^2))/2;
SlopeD = abs((m1-m2)/SDpool);
data1 = RealInterceptDist; data2 = SynInterceptDist;
m1 = mean(data1); m2 = mean(data2);
SDpool = sqrt(((std(data1))^2)+(std(data2)^2))/2;
InterceptD = abs((m1-m2)/SDpool);
sprintf('Cohen d of chage rate is %f', SlopeD)
sprintf('Cohen d of intercept is %f', InterceptD)
% %%%% plot part
F = figure(1);
d1 = RealSlopeDist; d2 = SynSlopeDist;
dall = [d1 d2]; mdall = mean(dall, 2);
titlestring = ['Slope distribution in real and synthetic data'];
axes = gca;
hold(axes,'on');
h1 = histogram(d1,'DisplayName','Real data','Parent', axes, ...
    'NumBins', 15, 'BinLimits', [min(mdall) max(mdall)],'FaceAlpha',0.3, 'EdgeAlpha',0.1, 'FaceColor','r');
h1.Normalization = 'probability';
h1Data = h1.Data; h1Count = h1.Values; 
h1Pr = h1Count./sum(h1Count); h1Bin = h1.BinEdges;
hold on;
h2 = histogram(d2, 'DisplayName','Synthetic data','Parent',axes, ...
    'NumBins', 15, 'BinLimits', [min(mdall) max(mdall)],'FaceAlpha',0.3, 'EdgeAlpha',0.1, 'FaceColor','b');
h2.Normalization = 'probability';
h2Data = h2.Data; h2Count = h2.Values; h2Pr = h2Count./sum(h2Count); 
h2Bin = h2.BinEdges;
xlabel('Slope in Linear Mixed Effect Model'); ylabel('Probability'); title(titlestring);
hold off;
legend(axes,'show');
F = figure(2);
d1 = RealInterceptDist; d2 = SynInterceptDist;
dall = [d1 d2]; mdall = mean(dall, 2);
titlestring = ['Intercept distribution in real and synthetic data'];
axes = gca;
hold(axes,'on');
h1 = histogram(d1,'DisplayName','Real data','Parent', axes, ...
    'NumBins', 15, 'BinLimits', [min(mdall) max(mdall)],'FaceAlpha',0.3, 'EdgeAlpha',0.1, 'FaceColor','r');
h1.Normalization = 'probability';
h1Data = h1.Data; h1Count = h1.Values; h1Pr = h1Count./sum(h1Count); 
h1Bin = h1.BinEdges;
hold on;
h2 = histogram(d2, 'DisplayName','Synthetic data','Parent',axes, ...
    'NumBins', 15, 'BinLimits', [min(mdall) max(mdall)],'FaceAlpha',0.3, 'EdgeAlpha',0.1, 'FaceColor','b');
h2.Normalization = 'probability';
h2Data = h2.Data; h2Count = h2.Values; h2Pr = h2Count./sum(h2Count); 
h2Bin = h2.BinEdges;
xlabel('Intercept in Linear Mixed Effect Model'); ylabel('Probability'); title(titlestring);
hold off;
legend(axes,'show');
figure(3);
FaceColor = [0.5 0.5 0.5];
BarWidth = 0.6;
bar([SlopeD InterceptD], 'FaceColor',FaceColor,'BarWidth',BarWidth);
ylim([0 1])
set(gca,'XTick',[1 2],'XTickLabel',{'|Cohen d| in slope','|Cohen d| in intercept'});
axes1.XAxis.FontSize = 14;
