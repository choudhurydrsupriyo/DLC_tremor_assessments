close all
clear all
clc
data=readtable('E:\Supriyo_DLC\ST_CDDLC_resnet50_cervical_dystoniaNov16shuffle1_500000 - Copy');
index_X=data.IDIP_X;
index_Y=data.IDIP_Y;
thumb_X=data.TD_X;
thumb_Y=data.TD_Y;
SS=30; %Hz
t=(data.bodyparts./30); %s
subplot(2,2,1);
plot(t(1:300),index_Y(1:300));
hold on 
%plot(t(1:300),index_X(1:300));
%hold on 
%plot(t(1:300),thumb_X(1:300),'--b');
%hold on
plot(t(1:300),thumb_Y(1:300),'--r');
xlabel ('Time (s)');
ylabel ('Pixels');
fftsz=120;  
meas={'Psn','Vel','Acc'};
for n=1:3
    
    subplot (2,2,n+1);
    L=floor(length(index_Y)/fftsz);
    data=reshape(index_Y(1:L*fftsz),[fftsz,L]);
    if n>1
        data=diff(data,n-1);
    end
    data=fft(data,[],1);
    data=data.*conj(data);
    pow=sum(data,2);
    f=linspace(0,15,fftsz/2+1);
    pow=pow/sum(pow(2:fftsz/2+1));
    plot(f(2:fftsz/2+1),pow(2:fftsz/2+1),'k-');
    xlabel ('Frequency (Hz)');
    ylabel ('Relative Power');
    title (meas{n});
    
end