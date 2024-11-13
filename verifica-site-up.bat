@echo off
setlocal enabledelayedexpansion

:: DOMINIOS A SEREM VERIFICADOS
set DOMINIO=www.seudominioaqui.com

:: VARIAVEIS DE CONTROLE
set CONT_FALHAS=0
set MAX_CONT=4

:: LOOP DE VERIFICAÇÃO
: LOOP

:: DEFINIÇÃO DA MENSAGEM DE AVISO
set MSG1="O DOMINIO WWW.SEUDOMINIODQUI.COM NAO ESTA RESPONDENDO"
echo Set objArgs = WScript.Arguments > %temp%\msgbox.vbs
echo MsgBox objArgs(0), 0, "AVISO" >> %temp%\msgbox.vbs

ping -n 1 %DOMINIO% > NUL
if errorlevel=1 ( 
set /a CONT_FALHAS+=1 
)else ( set CONT_FALHAS=0 )

:: TEMPO ENTRE AS VERIFICAÇÕES
timeout /t 30 > NUL

ping -n 1 %DOMINIO%  > NUL
if errorlevel=1 (
 set /a CONT_FALHAS+=1 
)else ( set CONT_FALHAS=0 )

:: VERIFICA CONEXÕES MAL SUCEDIDAS
if %CONT_FALHAS% geq %MAX_CONT% ( 
cscript //nologo %temp%\msgbox.vbs %MSG1% )

:: APAGAR MSG TEMPORÁRIA
del %temp%\msgbox.vbs

goto LOOP
