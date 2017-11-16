for k = 1:32
	plot(fft(eye(k+16)));
	axis([-1 1 -1 1])
	M(k) = getframe;
end

figure
movie(M,5)
v = VideoWriter('newfile.avi');
open(v);
writeVideo(v, M);
close(v);