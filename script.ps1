function Run-NodeVersion() {
    try {
        if ($(noded -v).Contains("12")) {
            echo "I'm using node 12 🤩"
            # Run Script
        }
        else {
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
                    Download-Nvm
                    $env:Path+=";C:\nvm"
                    nvm install 12
                    nvm use 12
                    echo "I'm using node 12 👀"
                    #Run SCript
                }
            }
        }
    }
    catch {
        Write-Host $_.Exception.Message -ForegroundColor Red
    }
} 
    function Download-Nvm() {
        $unZippedFolder = "C:\nvm"
        $zipFile = $location + "nvm.zip"
        Remove-Item -Recurse -Force *$unZippedFolder*
        curl -L https://github.com/coreybutler/nvm-windows/releases/download/1.1.8/nvm-noinstall.zip -o $zipFile
        Expand-Archive -path $zipFile -DestinationPath $unZippedFolder
        Remove-Item *$zipFile*
    }
    Run-NodeVersion