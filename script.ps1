function Run-NodeVersion() {
    try {
        if (nvm -v) {
            nvm install 12
            nvm use 12
            echo "I'm using node 12 😎"
            #Run Script
        }
    }
    catch {
        $nvmNotFound = $_.Exception.Message.Contains("is not recognized")
        if ($nvmNotFound) {
            Get-Nvm
            $env:Path += ";C:\nvm"
            nvm install 12
            nvm use 12
            echo "I'm using node 12 👀"
            #Run SCript
        }
    }
}
    
 
function Get-Nvm() {
    $folder = "C:\\nvm"
    $zipFile = "C:\\nvm.zip"
    if (Test-Path $folder) {
        Remove-Item -Recurse -Force $folder
    }
    Invoke-WebRequest -Uri https://github.com/coreybutler/nvm-windows/releases/download/1.1.8/nvm-noinstall.zip -OutFile $zipFile
    Expand-Archive -path $zipFile -DestinationPath $folder
    Remove-Item *$zipFile*
}
Run-NodeVersion