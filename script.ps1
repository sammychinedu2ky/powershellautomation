#Requires -RunAsAdministrator
function Run-NodeVersion() {
    try {
        if (nvm -version) {
            nvm install 12
            nvm use 12
            echo "I'm using node 12 😎"
            #Run Script
        }
    }
    catch {
        $nvmNotFound = $_.Exception.Message.Contains("is not recognized")
        if ($nvmNotFound) {
            $folder = "C:\nvm"
            $zipFile = "C:\nvm.zip"
            $nodePath = "C:\Program Files\nodejs"
            $settingsFile = "$folder/settings.txt"
            if (Test-Path $folder) {
                Remove-Item -Recurse -Force $folder
            }
            if (Test-Path $nodePath) {
                Remove-Item -Recurse -Force $nodePath
            }
            Invoke-WebRequest -Uri https://github.com/coreybutler/nvm-windows/releases/download/1.1.8/nvm-noinstall.zip -OutFile $zipFile
            Expand-Archive -path $zipFile -DestinationPath $folder
            Remove-Item $zipFile
            $path = [System.Environment]::GetEnvironmentVariable("Path", "User")
            [System.Environment]::SetEnvironmentVariable("NVM_HOME", $folder, "User")
            [System.Environment]::SetEnvironmentVariable("NVM_SYMLINK", $nodePath, "User")
            $newPath = $path + ";$folder;$nodePath"
            [System.Environment]::SetEnvironmentVariable("Path", $newpath, 'User')
            $env:Path = $newPath
            $env:NVM_HOME=$folder
            $env:NVM_SYMLINK=$nodePath
            New-Item -Path $folder -Name "settings.txt"
            Add-Content -Path $settingsFile  -Value "root: C:\nvm"
            Add-Content -Path $settingsFile -Value "path: $nodePath"
            nvm install 12
            nvm use 12
            echo "I'm using node 12 👀"
            #Run SCript
        }
    }
}
    

Run-NodeVersion