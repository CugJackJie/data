  a=mean(magic04) ;
  a=repmat (a,19020,1) ;
  Z=magic04-a;b=Z' *Z/19020;
  c =0 ;
  for i=1:19020
  a=Z(i,:)'* Z(i,:);
  c=a+c;
  end
 
