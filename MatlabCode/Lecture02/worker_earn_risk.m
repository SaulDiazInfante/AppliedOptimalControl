function x_t=worker_earn_risk(t,r,p_t, c_t, x_t_)
  indicator=1;
  z_t = unifrnd(-0.1,0.2,1);
  if t > 40.0
    indicator = 0.0;
  end
  w_t = 2.0 + t / 20.0 - (t / 20.0 - 1.0 )^2;
  I_t = ((1.0 + r)*p_t + (1.0+z_t)*(1.0-p_t))* x_t_;
  x_t = indicator * w_t + I_t - c_t;
  