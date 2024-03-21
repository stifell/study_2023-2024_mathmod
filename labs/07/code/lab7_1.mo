model lab7_1
parameter Real a = 0.66;
parameter Real b = 0.00006;
parameter Real N = 2010;

Real n(start=29);

equation
  der(n) = (a+b*n) * (N-n);
  
end lab7_1;