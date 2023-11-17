%Made by ѩ�˲�����  
%2023/03/15
%Wishing you to encourage yourself��

function pheromone=initial_pheromone(pheromone,point_end,mapdata)
%% 
%point_end   input       �յ�
%pheromone   output      ��Ϣ��
[x_max,y_max,z_max] = size(mapdata);%��ȡ��ͼ��С
for x=1:x_max
    for y=1:y_max
        for z=1:z_max
            pheromone(x,y,z)=5000/distance(x,y,z,point_end(1),point_end(2),point_end(3));
        end
    end
end
