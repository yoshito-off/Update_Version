@echo off
color 0A
title People's Vibe

rem Récupérer automatiquement le HWID
for /f "tokens=*" %%a in ('wmic csproduct get uuid ^| findstr /r "[a-fA-F0-9]"') do set "hwid=%%a"

rem Récupérer le chemin d'accès à mysql.exe depuis la variable d'environnement
set "MYSQL_PATH=%MYSQL_PATH%"

rem Définir les informations de connexion à la base de données MySQL
set "SERVER=45.140.164.151"
set "DATABASE=s16_Batch"
set "USERNAME=u16_sAJfXWINLX"
set "PASSWORD=@@rimms9zBU+Fb^21SfNzKEV"

:menu
cls
echo ========================
echo      People's Vibe
echo ========================
echo 1. Inscription
echo 2. Connexion
echo 3. Quitter
echo ========================
echo Ton HWID: %hwid%
set /p choix="Choisissez une option (1/2/3): "

if "%choix%"=="1" goto inscription
if "%choix%"=="2" goto connexion
if "%choix%"=="3" goto fin

:inscription
cls
echo ========================
echo       Inscription
echo ========================
set /p pseudo="Pseudo: "
set /p nom="Nom: "
set /p prenom="Prénom: "
set /p ville="Ville: "
set /p pays="Pays: "
set /p departement="Département: "
set /p dob="Date de Naissance (YYYYMMDD): "
set /p password="Mot de Passe: "

rem Crypter le mot de passe (utilise une méthode de cryptage plus robuste si possible)
setlocal enabledelayedexpansion
set "encryptedPassword="
for /L %%i in (0,1,31) do (
    set /a "char=!password:~%%i,1! ^ 42"
    set "encryptedPassword=!encryptedPassword!!char!"
)
endlocal

rem Envoyer les données à la base de données MySQL
"%MYSQL_PATH%\mysql.exe" -h %SERVER% -u %USERNAME% -p%PASSWORD% %DATABASE% -e "INSERT INTO utilisateurs (pseudo, nom, prenom, ville, pays, departement, dob, password, hwid) VALUES ('!pseudo!', '!nom!', '!prenom!', '!ville!', '!pays!', '!departement!', '!dob!', '!encryptedPassword!', '!hwid!')"

if !errorlevel! equ 0 (
    echo Inscription réussie!
) else (
    echo Erreur lors de l'inscription. Veuillez réessayer.
    echo Erreur MySQL: !errorlevel!
)
pause
goto menu

:connexion
cls
echo ========================
echo       Connexion
echo ========================
set /p pseudo="Pseudo: "
set /p password="Mot de Passe: "

rem Crypter le mot de passe (utilise une méthode de cryptage plus robuste si possible)
setlocal enabledelayedexpansion
set "encryptedPassword="
for /L %%i in (0,1,31) do (
    set /a "char=!password:~%%i,1! ^ 42"
    set "encryptedPassword=!encryptedPassword!!char!"
)
endlocal

rem Vérifier les informations dans la base de données MySQL
"%MYSQL_PATH%\mysql.exe" -h %SERVER% -u %USERNAME% -p%PASSWORD% %DATABASE% -e "SELECT * FROM utilisateurs WHERE pseudo = '!pseudo!' AND password = '!encryptedPassword!'"

if !errorlevel! equ 0 (
    echo Connexion réussie! HWID: %hwid%
) else (
    echo Identifiants incorrects. Veuillez réessayer.
    echo Erreur MySQL: !errorlevel!
)
pause
goto menu

:fin
cls
echo Au revoir!
