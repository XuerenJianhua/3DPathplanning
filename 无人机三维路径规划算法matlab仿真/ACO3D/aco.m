%Made by ѩ�˲�����  
%2023/03/15
%Wishing you to encourage yourself��

function [path,aco_cost,Number_of_searches,Number_of_successful_searches,Number_of_failed_searches]=aco(point1,point2,mapdata,popNum)
PopNum=popNum;    %��Ⱥ����
BestFitness=[];     %��Ѹ���
iter_max=100;%��������
[x_max,y_max,z_max] = size(mapdata);%��ȡ��ͼ��С
%% ��Ϣ�س�ʼ��
pheromone=ones(x_max,y_max,z_max);
pheromone=initial_pheromone(pheromone,point2,mapdata);
Number_of_searches=0;
Number_of_successful_searches=0;
Number_of_failed_searches=0;
%��ʼ������·��
[flag,judges,paths,pheromone,number_of_searches,number_of_successful_searches,number_of_failed_searches]=searchpath(PopNum,pheromone,point1,point2,mapdata);
%����������դ����Ŀ
Number_of_searches = Number_of_searches+number_of_searches;
Number_of_successful_searches=Number_of_successful_searches+number_of_successful_searches;
Number_of_failed_searches=Number_of_failed_searches+number_of_failed_searches;

fitness=CacuFit(judges,paths,PopNum);           %��Ӧ�ȼ���
[bestfitness,bestindex]=min(fitness);           %�����Ӧ��
bestpath=paths{1,bestindex};                    %���·��
%[worstfitness,worstindex]=max(fitness);		%���Ӧ��
%worstpath=paths{1,worstindex};					%�·��
BestFitness=[BestFitness;bestfitness];          %��Ӧ��ֵ��¼

%% ��Ϣ�ظ���
rou=0.3;%��Ϣ��˥��ϵ��
cfit=200/bestfitness;%��Ϣ������
[n,m]=size(bestpath);
for i=1:n
    %���ݾ��������Ӧ����Ϣ��
	pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))=(1-rou)*pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))+rou*cfit;
end

maxpathcost=[];
%% ѭ��Ѱ������·��
for iter=1:iter_max
    %% ·������
    Number_of_searches = Number_of_searches+1;
    if flag==1
        break;
    end
    [flag,judges,paths,pheromone,Number_of_searches,Number_of_successful_searches,Number_of_failed_searches]=searchpath(PopNum,pheromone,point1,point2,mapdata);
    Number_of_searches = Number_of_searches+number_of_searches;
    Number_of_successful_searches=Number_of_successful_searches+number_of_successful_searches;
    Number_of_failed_searches=Number_of_failed_searches+number_of_failed_searches;

    %% ��Ӧ��ֵ�������
    fitness=CacuFit(judges,paths,PopNum);%��Ӧ��ԽСԽ��
    [newbestfitness,newbestindex]=min(fitness);
    
    
    if newbestfitness<bestfitness
        bestfitness=newbestfitness;
		bestpath=paths{1,newbestindex};   
    end
    
    %%��ͼ��,figure(2)
    %maxpathcost_1=path_cost(bestpath);
    %maxpathcost=[maxpathcost;maxpathcost_1];
    
    %����ʵʱ·��
     %plot3(bestpath(:,1),bestpath(:,2),bestpath(:,3),'LineWidth',1,'color','r');
     %pause(0.01); %��ͣ����۲�
    
	BestFitness=[BestFitness;bestfitness];
    
    %% ������Ϣ��
    cfit=200/bestfitness;
	[n,m]=size(bestpath);
	for i=1:n
		pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))=(1-rou)*pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))+rou*cfit;
    end
   
end%for

% ���·��
path = bestpath;
%aco_cost=bestfitness;�����Ӧ��

%����·������
pathLength = 0;
for i=1:length(bestpath(:,1))-1
    pathLength = pathLength + distance(bestpath(i,1),bestpath(i,2),bestpath(i,3),bestpath(i+1,1),bestpath(i+1,2),bestpath(i+1,3));
end 
aco_cost = pathLength;




	




