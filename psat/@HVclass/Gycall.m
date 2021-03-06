function Gycall(a)

global DAE

if ~a.n, return, end

k = 0.995*3*sqrt(2)/pi;
c = 3/pi;

Idc = a.u.*DAE.x(a.Idc);
xr = DAE.x(a.xr);
xi = DAE.x(a.xi);

cosa = DAE.y(a.cosa);
cosg = DAE.y(a.cosg);
phir = a.u.*DAE.y(a.phir);
phii = a.u.*DAE.y(a.phii);
Vrdc = ~a.u + DAE.y(a.Vrdc);
Vidc = ~a.u + DAE.y(a.Vidc);
yr = DAE.y(a.yr);
yi = DAE.y(a.yi);

V1 = DAE.y(a.v1);
V2 = DAE.y(a.v2);

mr = a.con(:,11);
mi = a.con(:,12);
Kp = a.con(:,14);

P0 = a.con(:,27);
I0 = a.con(:,26);
uI = a.u.*a.dat(:,9);
uP = a.u.*a.dat(:,10);
uV = a.u.*a.dat(:,11);

za = cosa < a.dat(:,3) & cosa > a.dat(:,4) & a.u; 
zg = cosg < a.dat(:,5) & cosg > a.dat(:,6) & a.u;
zr = yr < a.con(:,21) & yr > a.con(:,22) & a.u; 
zi = yi < a.con(:,23) & yi > a.con(:,24) & a.u;

DAE.Gy = DAE.Gy ...
         + sparse(a.bus1,a.Vrdc,Idc,DAE.m,DAE.m) ...
         - sparse(a.bus2,a.Vidc,Idc,DAE.m,DAE.m) ...
         + sparse(a.v1,a.phir,k*V1.*mr.*Idc.*cos(phir),DAE.m,DAE.m) ...
         + sparse(a.v2,a.phii,k*V2.*mi.*Idc.*cos(phii),DAE.m,DAE.m) ...
         + sparse(a.v1,a.v1,k*mr.*Idc.*sin(phir),DAE.m,DAE.m) ...
         + sparse(a.v2,a.v2,k*mi.*Idc.*sin(phii),DAE.m,DAE.m) ...
         - sparse(a.cosa,a.cosa,1,DAE.m,DAE.m) ...
         + sparse(a.cosa,a.yr,za.*Kp,DAE.m,DAE.m) ...
         - sparse(a.cosa,a.Vrdc,za.*Kp.*uV,DAE.m,DAE.m) ...
         - sparse(a.Vrdc,a.Vrdc,1,DAE.m,DAE.m) ...
         + sparse(a.Vrdc,a.v1,k*cosa.*mr,DAE.m,DAE.m) ...
         + sparse(a.Vrdc,a.cosa,k*za.*V1.*mr,DAE.m,DAE.m) ...
         + sparse(a.phir,a.phir,k*mr.*V1.*sin(phir),DAE.m,DAE.m) ...
         + sparse(a.phir,a.Vrdc,1,DAE.m,DAE.m) ...
         - sparse(a.phir,a.v1,k*mr.*cos(phir),DAE.m,DAE.m) ...
         + sparse(a.phii,a.phii,k*mi.*V2.*sin(phii),DAE.m,DAE.m) ...
         + sparse(a.phii,a.Vidc,1,DAE.m,DAE.m) ...
         - sparse(a.phii,a.v2,k*mi.*cos(phii),DAE.m,DAE.m) ...
         - sparse(a.yr,a.yr,1,DAE.m,DAE.m) ...
         + sparse(a.yr,a.Vrdc,-zr.*uP.*P0./Vrdc./Vrdc,DAE.m,DAE.m) ...
         - sparse(a.cosg,a.cosg,1,DAE.m,DAE.m) ...
         - sparse(a.cosg,a.yi,zg.*Kp,DAE.m,DAE.m) ...
         + sparse(a.cosg,a.Vidc,zg.*Kp.*uV,DAE.m,DAE.m) ...
         - sparse(a.Vidc,a.Vidc,1,DAE.m,DAE.m) ...
         + sparse(a.Vidc,a.v2,k*cosg.*mi,DAE.m,DAE.m) ...
         + sparse(a.Vidc,a.cosg,k*zg.*V2.*mi,DAE.m,DAE.m) ...
         - sparse(a.yi,a.yi,1,DAE.m,DAE.m) ...
         + sparse(a.yi,a.Vidc,-zi.*uP.*P0./Vidc./Vidc,DAE.m,DAE.m);
