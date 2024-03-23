model lab7_2
parameter Real a = 0.000066;
parameter Real b = 0.6;
parameter Real N = 2010;

Real n(start=29);

equation
  der(n) = (a+b*n) * (N-n);
  
end lab7_2;