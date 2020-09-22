clear all;close all
%Crea la pagina argoesstatus.html con el google mapa de las posiciones de
%las boyas Argo-Es y las Argo-In

%% Read configuration
configArgoSpainWebpage

%CoberturaArgoGlobal
CoberturaArgoGlobal=4000;


%% Begin
fprintf('>>>>> %s\n',mfilename)

% Read Data
DataArgoEs=load(strcat(PaginaWebDir,'/data/dataArgoSpain.mat'),'activa','iactiva','iinactiva','inodesplegada','FechaUltimoPerfil','WMO','UltimoVoltaje','UltimoSurfaceOffset');
BoyasActivaArgoEs=DataArgoEs.iactiva;

%Numerto total de perfiles medidos
for ifloat=1:length(DataArgoEs.WMO)
    FloatData=load(fullfile(DirArgoData,'Floats',num2str(DataArgoEs.WMO(ifloat))),'HIDf');
    NTotalPerfiles=[NTotalPerfiles nanmax(FloatData.HIDf.cycle)'];
end


%% Begin
fprintf('>>>>> %s\n',mfilename)

BoyasActivaArgoEs=25;

fid = fopen(FileTableArgoEsStatus,'w');
fprintf('     > Writting Google Earth file \n');
fprintf(fid,'<!DOCTYPE html> \n');
fprintf(fid,'<html>  \n');
fprintf(fid,'<head> \n');
fprintf(fid,'<meta name="viewport" content="width=device-width, initial-scale=1">  \n');
fprintf(fid,'<style>  \n');
fprintf(fid,'table { \n');
  fprintf(fid,'text-align: center; \n');
  fprintf(fid,'margin-left: auto; \n');
  fprintf(fid,'margin-right: auto; \n');
  fprintf(fid,'max-width: 100%%; \n');
  fprintf(fid,'background-attachment: fixed; \n');
  fprintf(fid,'font-weight: bold;  \n');
  fprintf(fid,'border-collapse: collapse; \n');
  fprintf(fid,'font-family: Montserrat;  \n');
  fprintf(fid,'}  \n');
  fprintf(fid,'@font-face { font-family: Poppins; src: url(''POPPINS.TTF''); } \n');
 fprintf(fid,'     h1 {  \n');
  fprintf(fid,'       font-family: Poppins  \n');
      fprintf(fid,'}  \n');
fprintf(fid,'td {   \n');
  fprintf(fid,'border: 10px solid #00A2DD;   \n');
  fprintf(fid,'font-weight: bolder;   \n');
  fprintf(fid,'color:#FFFFFF;   \n');
  fprintf(fid,'font-weight: 700;   \n');
  fprintf(fid,'font-size: 14px;  \n');
  fprintf(fid,'text-align: center;   \n');
  fprintf(fid,'width: calc(20%%); padding: 10px;  \n');
    fprintf(fid,'overflow: hidden;   \n');
    fprintf(fid,'font-size: 1vw; /* <---- the viewport relative font-size */   \n');
  fprintf(fid,'background-color: #00A2DD   \n');
fprintf(fid,'}   \n');
fprintf(fid,'th {   \n');
  fprintf(fid,'border: 10px solid #00A2DD;   \n');
  fprintf(fid,'color:#FFFFFF;   \n');
  fprintf(fid,'font-weight: 900;  \n');
  fprintf(fid,'font-size: 70px;   \n');
  fprintf(fid,'text-align: center;   \n');
  fprintf(fid,'width: calc(20%%); padding: 10px;  \n');
    fprintf(fid,'overflow: hidden;   \n');
    fprintf(fid,'font-size: 8vw; /* <---- the viewport relative font-size */   \n');
  fprintf(fid,'background-color: #00A2DD   \n');
fprintf(fid,'}   \n');
fprintf(fid,'tr:nth-child(even) {   \n');
  fprintf(fid,'background-color: #00A2DD;   \n');
  fprintf(fid,'text-align: center;  \n');
fprintf(fid,'}   \n');
fprintf(fid,'</style>   \n');
fprintf(fid,'</head>   \n');
fprintf(fid,'<body>   \n');
fprintf(fid,'<center>   \n');
fprintf(fid,'<table>  \n');  
  fprintf(fid,'<tr>   \n');
    fprintf(fid,'    <th>%d</th> \n',BoyasActivaArgoEs);
fprintf(fid,'    <th>10,993</th> \n');
fprintf(fid,'    <th>%3.1f%%</th> \n',BoyasActivaArgoEs/CoberturaArgoGlobal*100);
  fprintf(fid,'</tr>   \n');
  fprintf(fid,'<tr>   \n');
    fprintf(fid,'<td>PERFILADORES</td>   \n');
    fprintf(fid,'<td>PERFILES OCEANOGR&Aacute;FICOS</td>   \n');
    fprintf(fid,'<td>COBERTURA GLOBAL</td>   \n');
  fprintf(fid,'</tr>   \n');
fprintf(fid,'</table>  \n');
fprintf(fid,'</div>  \n');
fprintf(fid,'</center>   \n');
fprintf(fid,'</body>   \n');
fprintf(fid,'</html>   \n');

fclose(fid);

%% Ftp the file
fprintf('     > Uploading  %s \n',FileTableArgoEsStatus);
ftpobj=FtpOceanografia;
var=cd(ftpobj,'/html/argo/html_files');
outftp=mput(ftpobj,FileTableArgoEsStatus);


fprintf('%s <<<<< \n',mfilename)
fprintf('Archivo modificado y actualizado en el servidor')


%PARRAFO DE PRUEBA PARA COMPROBAR FUNCIONAMIENTO DE GIT PUSH