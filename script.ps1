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
                    $env:Path+=";C:\nvm"
                    nvm install 12
                    nvm use 12
                    echo "I'm using node 12 👀"
                    #Run SCript
                }
            }
        }
    
 
    function Get-Nvm() {
        $unZippedFolder = "C:\\nvm"
        $zipFile = $location + "nvm.zip"
        Remove-Item -Recurse -Force "C:\\*nvm*"
        curl -L https://github.com/coreybutler/nvm-windows/releases/download/1.1.8/nvm-noinstall.zip -o $zipFile
        Expand-Archive -path $zipFile -DestinationPath $unZippedFolder
        Remove-Item *$zipFile*
    }
    Run-NodeVersion