clear
load ground_true_desikan1.mat
load PLV_desikan.mat

iter1 = 0;
for ratio = 0.1:0.1:1
    iter1 = iter1+1;
iter = 0;
for i = 1:5
    i
     j = 3;
        for m = 1:size(PLV1,1)
            iter = iter+1;
            tem = eval(['PLV',num2str(i)]);
            tem1 = squeeze(tem(m,:,1,j));
            tem1(tem1>0.99999)=[];
            b=zeros(length(ground_true));
            bw=true(length(ground_true));
            b(triu(bw,1)) = tem1;
            b = b+b';
            network = b; 
            network1 = threshold_proportional(network, ratio);
            mod1(i,m) = efficiency_wei(network1);
            [~,mod2(i,m)] = community_louvain(network1);
            network2 = null_model_und_sign(network1);
            mod3(i,m) = efficiency_wei(network2);
            [~,mod4(i,m)] = community_louvain(network2);
            network1(network1~=0) = 1;
            mod5(i,m) = efficiency_wei(network1);
            [~,mod6(i,m)] = community_louvain(network1);
        end
end
    M1(:,:,iter1) = mod1;M2(:,:,iter1) = mod2;
    M3(:,:,iter1) = mod3;M4(:,:,iter1) = mod4;
    M5(:,:,iter1) = mod5;M6(:,:,iter1) = mod6;
end
figure
x_axis = 5;
subplot(3,2,1)
for i = 1:size(M1,3)
    errorbar(mean(squeeze(M1(:,:,i))'),std(squeeze(M1(:,:,i))'),'LineWidth',2)
    axis([0 x_axis,-inf,inf])
    hold on
end
subplot(3,2,2)
for i = 1:size(M1,3)
    errorbar(mean(squeeze(M2(:,:,i))'),std(squeeze(M2(:,:,i))'),'LineWidth',2)
    axis([0 x_axis,-inf,inf])
    hold on
end
subplot(3,2,3)
for i = 1:size(M1,3)
    errorbar(mean(squeeze(M3(:,:,i))'),std(squeeze(M3(:,:,i))'),'LineWidth',2)
    axis([0 x_axis,-inf,inf])
    hold on
end
subplot(3,2,4)
for i = 1:size(M1,3)
    errorbar(mean(squeeze(M4(:,:,i))'),std(squeeze(M4(:,:,i))'),'LineWidth',2)
    axis([0 x_axis,-inf,inf])
    hold on
end
subplot(3,2,5)
for i = 1:size(M1,3)
    errorbar(mean(squeeze(M5(:,:,i))'),std(squeeze(M5(:,:,i))'),'LineWidth',2)
    axis([0 x_axis,-inf,inf])
    hold on
end
subplot(3,2,6)
for i = 1:size(M1,3)
    errorbar(mean(squeeze(M6(:,:,i))'),std(squeeze(M6(:,:,i))'),'LineWidth',2)
    axis([0 x_axis,-inf,inf])
    hold on
end