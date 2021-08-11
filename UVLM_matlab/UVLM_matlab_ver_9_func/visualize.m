n_data = par.tot_time_step;

figure
% set(gcf,'Units','normalized','Position',[0 0 1 1]);

% comment if gif not needed
% fig_pos = get(gcf,'Position');
% width = fig_pos(3);
% height = fig_pos(4);
% im = zeros(height,width,1,nt,'uint8');
% gif_fps = 24;

for vis = 1:n_data
    abs_mat = ini.absolute_coord{vis};
    twenty_chord_length = ini.chord_20_cell{vis};
    
    airfoil_coord = abs_mat(1:par.npan+1,:);
    core_vortices = abs_mat(par.npan+2:end,:);
    
    pos = ini.csv(twenty_chord_length)>0;
    neg = ini.csv(twenty_chord_length)<0;
    
    pos_cores = core_vortices(pos,:);
    neg_cores = core_vortices(neg,:);
    
    if vis == 1
        pl_h1 = plot(airfoil_coord(:,1),airfoil_coord(:,2),'k'); grid on; hold on;
        pl_h2 = plot(airfoil_coord([1 par.npan/2+1],1),airfoil_coord([1 par.npan/2+1],2),'k'); hold on;
        if isempty(pos_cores)
            pos_cores = neg_cores;
        else
            neg_cores = pos_cores;
        end
        pl_h3 = plot(pos_cores(:,1),pos_cores(:,2),'b.'); hold on;
        pl_h4 = plot(neg_cores(:,1),neg_cores(:,2),'r.'); hold off;
        
        axis([0 300 -5 5])
        
%         comment if gif not needed
%         frame = getframe(gcf);
%         [im,map] = rgb2ind(frame.cdata,256,'nodither');

    else        
        set(pl_h1,'Xdata',airfoil_coord(:,1),'Ydata',airfoil_coord(:,2))
        set(pl_h2,'Xdata',airfoil_coord([1 par.npan/2+1],1),'Ydata',airfoil_coord([1 par.npan/2+1],2))
        set(pl_h3,'Xdata',pos_cores(:,1),'Ydata',pos_cores(:,2))
        set(pl_h4,'Xdata',neg_cores(:,1),'Ydata',neg_cores(:,2))
        
%         comment if gif not needed
%         frame = getframe(gcf);
%         im(:,:,1,vis)=rgb2ind(frame.cdata,map,'nodither');
        
    end
   
end

% comment if GIF not needed
% imwrite(im,map,'flow_visualize.gif','DelayTime',1/gif_fps,'Loopcount',inf);