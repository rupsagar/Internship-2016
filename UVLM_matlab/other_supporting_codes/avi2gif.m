vid_name = 'wake_compare_UVLM_1000_kh04';
vid_ext = '.avi';

vid_obj = VideoReader([vid_name vid_ext]);
tot_num_frame = vid_obj.NumberOfFrames;

vid_obj = VideoReader([vid_name vid_ext]);

frame_num = 1;

while hasFrame(vid_obj)
    frame.cdata = readFrame(vid_obj);
    if frame_num == 1
        [im,map] = rgb2ind(frame.cdata,256,'nodither');
        im(:,:,1,tot_num_frame) = 0;
    else
        im(:,:,1,frame_num) = rgb2ind(frame.cdata,map,'nodither');
    end
    frame_num = frame_num+1;
end

imwrite(im,map,[vid_name '.gif'],'DelayTime',0,'Loopcount',inf); % comment if GIF not needed