function Run-NodeVersion() {
    try {
        if (nvm -version) {
            Write-Host "Installing nvm...." -ForegroundColor Yellow
            nvm install 12.22.6
            nvm use 12.22.6
            npm install express
            #Run Script
        }
    }
    catch {
        $nvmNotFound = $_.Exception.Message.Contains("is not recognized")
        if ($nvmNotFound) {
            $folder = "$Home\nvm"
            $zipFile = "$Home\nvm.zip"
            $nodePath = "$Home\nodejs"
            $settingsFileLocation = "$folder/settings.txt"
            $settingsFileName = "settings.txt"
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
            $env:Path += $newPath
            $env:NVM_HOME=$folder
            $env:NVM_SYMLINK=$nodePath
            New-Item -Path $folder -Name "$settingsFileName"
            Add-Content -Path $settingsFileLocation  -Value "root: $folder"
            Add-Content -Path $settingsFileLocation -Value "path: $nodePath"
            Write-Host "Installing nvm...." -ForegroundColor Yellow
            nvm install 12.22.6
            nvm use 12.22.6
            npm install express
            #Run SCript
        }
    }
}
    

Run-NodeVersion
