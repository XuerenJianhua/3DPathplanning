%Made by ѩ�˲�����  
%2023/03/15
%Wishing you to encourage yourself��


function [rrt_path,rrt_cost,Number_of_searches,Number_of_successful_searches,Number_of_failed_searches] = RRT_main(source,goal,map,step)
%��������
[x_max,y_max,z_max ] = size(map);%��ͼ��Χ
stepsize = step; %����
threshold = 5; %��ֵthreshold������Ŀ���ľ��룬С�ڸ���ֵ����Ϊ����Ŀ���
maxFailedAttempts = 10000;%����������

searchSize = [x_max y_max z_max];  %�����ռ�
RRTree = double([source -1]);%�������
pathFound = false;%�Ƿ��ҵ�����·��
Number_of_searches = 0;%��¼����������դ����Ŀ���ɹ�+ʧ��
Number_of_successful_searches = 0;%�����ɹ�����Ŀ
Number_of_failed_searches=0;%ʧ�ܵ�������Ŀ
%% ѭ��
failedAttempts = 0;
while failedAttempts <= maxFailedAttempts  % ѭ������rrt
    %% ѡ��һ���������
    Number_of_searches= Number_of_searches+1;%����һ���ڵ���ͳ����Ŀ��һ
    if rand < 0.4
        sample = ceil(rand(1,3) .* searchSize);   % r�����������
    else
        sample = goal; % ������ΪĿ�꣬ʹ������ƫ��Ŀ��
    end
    %% ѡ��RRT������ӽ�qrand�Ľڵ�
    %min(B,[],dim)����ά�� dim(1��/2��) �ϵ���СԪ�� 
    %A������Сֵ��I������Сֵ����λ��
    [A, I] = min( distanceCost3(RRTree(:,1:3),sample) ,[],1); % ��ÿһ�е���Сֵ
    closestNode = floor(RRTree(I(1),1:3));
    %% ��qrand�ķ����ϴ�qrand����ƶ�һ����������
%     %����һ��
%     %����ֱ�ߵĲ�����ʽ
%     p1 = closestNode; p2 = sample; v = p2 - p1;
%     %syms t;line = p1 + t*v;
%     % ����ֱ�߳���
%     line_length = norm(v);
%     % �����µ��λ��
%     % �������stepsize����λ����
%     newPoint = floor(p1 + (stepsize / line_length) * v);  % ����ֱ�߷����ƶ�
%     %������
    movingVec = [sample(1)-closestNode(1),sample(2)-closestNode(2),sample(3)-closestNode(3)];
    movingVec = movingVec/sqrt(sum(movingVec.^2));  %��λ��
    newPoint = floor(closestNode + stepsize * movingVec);
    newPoint_isfeasible = checkPath3(closestNode, newPoint, map);
    
     if ~newPoint_isfeasible % �Ƿ���������Ľڵ���չ���µ��ǿ��е�
        failedAttempts = failedAttempts + 1;
        Number_of_failed_searches=Number_of_failed_searches+1;
        continue;
     end
    %�½ڵ����,���ͳ����Ŀ��1
    Number_of_successful_searches = Number_of_successful_searches+1;
    %����Ŀ���
    if distanceCost3(newPoint,goal) < threshold, pathFound = true; break; end 
    [A, I2] = min( distanceCost3(RRTree(:,1:3),newPoint) ,[],1); % ����½ڵ��Ƿ��Ѿ�����������
    if distanceCost3(newPoint,RRTree(I2(1),1:3)) < threshold, failedAttempts = failedAttempts + 1; continue; end 
    
    RRTree = [RRTree; newPoint I(1)]; % ��ӽڵ�
    failedAttempts = 0;
    
    %plot3([closestNode(1);newPoint(1)],[closestNode(2);newPoint(2)],[closestNode(3);newPoint(3)],'LineWidth',1); 
    %pause(0.01);%��ͣ����۲�
end
if pathFound, plot3([closestNode(1);goal(1)],[closestNode(2);goal(2)],[closestNode(3);goal(3)]); end
if ~pathFound, disp('no path found. maximum attempts reached'); end
%% �Ӹ���Ϣ����·��
path = goal;
prev = I(1);
while prev > 0
    path = [RRTree(prev,1:3); path];
    prev = RRTree(prev,4);
end
%����·������
pathLength = 0;
for i=1:length(path(:,1))-1, pathLength = pathLength + distanceCost3(path(i,1:3),path(i+1,1:3)); end 

rrt_path = path;%���ؽ��
rrt_cost=pathLength;

