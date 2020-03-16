
setlocal

IF NOT DEFINED SERVER_BUILD_CONFIG SET SERVER_BUILD_CONFIG=Debug
IF DEFINED GIT_COMMIT SET COMMIT_HASH=%GIT_COMMIT%

IF NOT DEFINED MSBUILD_PATH SET MSBUILD_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin

echo COMMIT HASH: %COMMIT_HASH%

:: change working directory to script directory
pushd "%~dp0/.."

:: restore NuGet packages
Scripts\nuget.exe restore JenkinsTry.sln
if %errorlevel% neq 0 exit /b %errorlevel%


:: build solution

:: call "%VS140COMNTOOLS%\vsvars32.bat"
echo "%MSBUILD_PATH%\msbuild.exe" JenkinsTry.sln /p:Configuration=%SERVER_BUILD_CONFIG% /m
"%MSBUILD_PATH%\msbuild.exe" JenkinsTry.sln /p:Configuration=%SERVER_BUILD_CONFIG% /m
if %errorlevel% neq 0 exit /b %errorlevel%




popd
