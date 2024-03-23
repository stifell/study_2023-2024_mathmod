model lab7_3
parameter Real a = 0.66;
parameter Real b = 0.6;
parameter Real N = 2010;

Real n(start=29);

equation
  der(n) = (a*time+b*time*n) * (N-n);
  
end lab7_3;