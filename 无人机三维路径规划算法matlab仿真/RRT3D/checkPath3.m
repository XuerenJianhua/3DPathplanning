%Made by ѩ�˲�����  
%2023/03/15
%Wishing you to encourage yourself��

%�������չ·���Ƿ�ᾭ���ϰ����;���ϰ����򲻿���
function feasible=checkPath3(node,newPos,map)
    feasible=false;%Ĭ��·��������
    %�ж��¾ɽڵ��Ƿ��ڿ��з�Χ��
    if (feasiblePoint3(node,map) && feasiblePoint3(newPos,map))
        %�ж��¾ɽڵ�������Ƿ�Խ�ϰ���
        p1 = node;
        p2 = newPos;
        % ����ֱ�ߵĲ�����ʽ�ͳ���
        v = p2 - p1; line_length = norm(v);
        % ������ȷֲ��ĵ�ĵ����Ŀ
        num_points = ceil(line_length);
        point_distances = linspace(0, line_length, num_points);
        points_on_line = repmat(p1, num_points, 1) + (point_distances' ./ line_length) * v;
        %����ֱ���ϵ����е㣬���ж�ֱ���Ƿ񾭹��ϰ���
        points_on_line_floor = floor(points_on_line);
        feasible_path=true;
        for i = 1:num_points
            x = points_on_line_floor(i,1);
            y = points_on_line_floor(i,2);
            z = points_on_line_floor(i,3);
            if map(x,y,z) ~= 0%�˴������ϰ���
               
                feasible_path=false;
                              break;
            end
        end%for
        
       if feasible_path
           
        feasible=true;
       end
    end%if
    
    
    
    
end






% function feasible=checkPath3(node,newPos,map)
% feasible=true;%Ĭ��·������
% 
% movingVec = [newPos(1)-node(1),newPos(2)-node(2),newPos(3)-node(3)];
% movingVec = movingVec/sqrt(sum(movingVec.^2)); %��λ��
% for R=0:0.5:sqrt(sum((node-newPos).^2))
%     posCheck=node + R .* movingVec;
%     %ceil����ȡ��,floor����ȡ��
%     if ~(feasiblePoint3(ceil(posCheck),map) && feasiblePoint3(floor(posCheck),map))
%         feasible=false;break;
%     end
% end
% if ~feasiblePoint3(newPos,map), feasible=false; end
% end





