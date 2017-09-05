clear
N_paths=1000;
hold on
sum=zeros(55,1);
t=1:55;
for i=1:1:N_paths
    X_t = life_cicle_allocation_path();
    sum = sum + X_t;
    patchline(t, X_t,'linestyle','-','linewidth',1,'edgealpha',0.03)
end
EX_t = sum/N_paths;
plot(EX_t, 'r-','LineWidth',2)
hold off
xlabel({'time','(in periods)'})
ylabel('Asset (standard Currency)')
legend('path','mean')
