@echo off


::ʹ��˵��
::1�����ļ�������Ŀ����pom.xml��readme.txt��һ��
::2�����Ӧ�øı�Ļ�ֻ��Ҫ�޸ı���jarFile����
::Ӧ�����ƣ���Ӧ�ú�ֻ��Ҫ�޸����Ｔ��
set jarFile=wfengine.jar

::�˵���ʾ��Ϣ
:menu
echo   ==================================
echo   = 1::uat������ϴ����Է�����     =
echo   = 2::prd������ϴ���ʽ������     =
echo   = 3::�˳�������                  =
echo   = q::�˳�������                  =
echo   ==================================
echo.
::�ж�ģ��
set /p input=-^> ������ѡ��: 
cls
if "%input%"=="1" goto uat
if "%input%"=="2" goto prd
if "%input%"=="3" goto exit
if "%input%"=="q" goto exit

:uat
::���Ի���������Ϣ�����
set Ip=10.92.82.44
set user=oaftp
set password=h9x0dxl6
set uploadPath=/home/hrpamgt/simbestboot
call mvn clean package -Dmaven.test.skip=true -Puat

::��ת�ϴ�jar��ģ��
call :upload
goto menu


:prd
::��������������Ϣ�����
set uploadPath=/cmcc/apps
call mvn clean package -Dmaven.test.skip=true -Pprd
::��ʽ����10.92.82.140�û���������
::���Ի���������Ϣ�����
set Ip=10.92.82.140
set user=oaapp
set password=9NPp#%%p$
::��ת�ϴ�jar��ģ��
call :upload


::��ʽ����10.92.82.141�û���������
::���Ի���������Ϣ�����
set Ip=10.92.82.141
set user=oaapp
set password=3%%!9Mdj9
::��ת�ϴ�jar��ģ��
call :upload
goto menu

::������ǩ(��÷ŵ�upload��ǩ����)
:exit
exit

::�ϴ�j�ļ�����Ӧ������
:upload
set d="%cd%"
set ftpConf=ftp.conf
cd /D %d%
echo open %Ip%>%ftpConf%
echo %user%>>%ftpConf%
echo %password%>>%ftpConf%
echo cd %uploadPath%>>%ftpConf%
echo lcd target>>%ftpConf%
echo bin>>%ftpConf%
echo rename %jarFile% %jarFile%.%date:~0,4%%date:~5,2%%date:~8,2%-%time:~0,5%.bak>>%ftpConf%
echo put %jarFile%>>%ftpConf%
echo close>>%ftpConf%
echo bye>>%ftpConf%
::Ӧ��ftp������Ӧ�ϴ�����
ftp -i -s:"%d%\%ftpConf%"
::ɾ����ʱ�ļ�
del %ftpConf%
echo =====================================================================================
echo =====================================================================================
echo ==�ļ����ϴ��� %Ip% ��Ŀ¼ %uploadPath%����ȷ�ϲ�����Ӧ�ã�
echo =====================================================================================
echo =====================================================================================
echo.
echo.
