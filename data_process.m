%clear all;
fp=fopen('OS_data.dat','rb');
pid=uint32(zeros(1,19500));
pid2=uint32(zeros(1,19500));
toa=uint64(zeros(1,19500));
tos=uint64(zeros(1,19500));
toe=uint64(zeros(1,19500));
for i= 1:19500
    pid(i)=fread(fp,1,'uint32');
    pid2(i)=fread(fp,1,'uint32');
    toa(i)=fread(fp,1,'uint64');
    tos(i)=fread(fp,1,'uint64');
    toe(i)=fread(fp,1,'uint64');
end
fclose(fp);
pids=zeros(1,1);
meanService = uint64(0);
meanWait=uint64(0);
meanIWait=uint64(0);
da=0;
db=0;
dc=0;
bad=0;
point=1;
for i=1:19500
    a(i) = (toe(i)-tos(i));
    b(i) = (toe(i)-toa(i));
    c(i) = (tos(i)-toa(i));
    da=double(a);
    db=double(b);
    dc=double(c);
    if a(i) > 100000 ||b(i) >100000 || c(i) > 100000
        a(i)=0;
        b(i)=0;
        c(i)=0;
        bad=bad+1;
        
    end
    meanService = meanService + a(i);
    meanWait = meanWait + b(i);
    meanIWait = meanIWait +c(i);
    
    flag1=1;
    for j=1:point-1
        if pid(i)== pids(j)
            flag1=0;
        end
    end
    if flag1==1
        pids(point)=pid(i);
        point=point+1;
    end
end
atoa=toa-toa(1);
atos=tos-toa(1);
atoe=toe-toa(1);
service = double(atoe-atos);
responce= double(atoe-atoa);
ratio=service./responce;
meanserv= sum(service)/19500;
meanresp= sum(responce)/19500;
%plot(atoa,ratio);
run=0;
arr=zeros(1,40);
for i=1:19500
    for j=0:39
        if(service(i)< j)
            arr(j+1)=arr(j+1)+1;
        end
    end
     
end

%figure,plot(0:1:39,arr);
arrcfq=arr;
xlabel('Time in ms');
ylabel('No of Requests');
title('Service Time Distribution GREEDY');