function k = K(theta)
  % theta идл╫

  thetaWithRadian = AngleToRadian(theta);

  c = cos(thetaWithRadian);
  s = sin(thetaWithRadian);

  k = [ c^2 s*c -c^2 -s*c; s*c s^2 -s*c -s^2; -c^2 -s*c c^2 s*c; -s*c -s^2 s*c s^2 ];

end
