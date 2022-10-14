@echo off
color 71

echo Usuario Logado: %username%		Computador: %computername%
date /t
echo.
set /p usuario= "Digite o usuario:"
echo.
rem O executavel Editv64.exe deve ser inserido no c:\windows\system32\, este executavel oculta a digiração da senha.
rem EditV64 -p "Digite a senha:" -m senha
EditV64 -m -p "Digite a senha:" senha
echo.


if exist "c:\openvpn\%usuario%.*" (
	rem -------- Verifica a instalacao do OpenVPN ----------------------------
		if exist "C:\Program Files\OpenVPN\bin\openvpn-gui.exe" (
				echo Concetando VPN

				"C:\Program Files\OpenVPN\bin\openvpn-gui.exe" --connect client2tnsp.ovpn --silent_connection 1
			
			cls
	) else (
		echo "Instalacao do OpenVPN inexistente."
		pause
		exit
)
	rem --------- --------------------------------------------------------------------


) else (
	echo Certificado nao existe
	pause
	exit
)

rem echo %usuario%
rem echo %senha%

echo on
net time \\192.168.1.5 /set /yes

REM ------ desconecta unidades------
net use P: /delete
net use S: /delete
net use Y: /delete
net use T: /delete
net use K: /delete
net use U: /delete

REM ---------------------------------

REM ------  Mapeamentos

net use T: \\servidor\TABNOT /user:2tnsp.intra\%usuario% %senha% /persistent:yes
net use S: \\servidor\Siplan
net use K: \\servidor\escrituras$
net use P: \\servidor\Publico
net use U: \\servidor\userfiles$\%username% 
