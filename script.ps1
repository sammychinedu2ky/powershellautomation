#Requires -RunAsAdministrator
function Run-NodeVersion() {
    try {
        if (nvm -version) {
            "nvm install 12.22.6" | cmd
            "nvm use 12.22.6" | cmd
            echo "I'm using node 12 😎"
            npm install express
            #Run Script
        }
    }
    catch {
        $nvmNotFound = $_.Exception.Message.Contains("is not recognized")
        if ($nvmNotFound) {
            $folder = "C:$Home\nvm"
            $zipFile = "C:\$Home\nvm.zip"
            $nodePath = "C:\$Home\Program Files\nodejs"
            $settingsFile = "$folder/settings.txt"
            $settingsFile = "settings.txt"
            if (Test-Path $nodePath) {
                Remove-Item -Recurse -Force $nodePath
            }
            if (Test-Path $folder) {
                Remove-Item -Recurse -Force $folder
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
            New-Item -Path $folder -Name "$settingsFile"
            Add-Content -Path $settingsFile  -Value "root: $folder"
            Add-Content -Path $settingsFile -Value "path: $nodePath"
            "nvm install 12.22.6" | cmd
            "nvm use 12.22.6" | cmd
            echo "I'm using node 12 👀"
            npm install express
            #Run SCript
        }
    }
}
    

Run-NodeVersion