

    Write-Host "`n"
    Write-Host " ____________________________________________________________________________ " -ForegroundColor Red 
    Write-Host "|                                                                            |" -ForegroundColor Red 
    Write-Host "|                                 L A Z Y - S E P                            |" -ForegroundColor Red 
    Write-Host "|                                                                            |" -ForegroundColor Red
    Write-Host "|                                 Version 2022.11                            |" -ForegroundColor Red 
    Write-Host "|____________________________________________________________________________|" -ForegroundColor Red 
    Write-Host "|                                                                            |" -ForegroundColor Red 
    Write-Host "|                                   Created by                               |" -ForegroundColor Red 
    Write-Host "|                                Matteo Ripamonti                            |" -ForegroundColor Red 
    Write-Host "|____________________________________________________________________________|" -ForegroundColor Red 
    Write-Host ""
    Write-Host "`n"

Write-Host "All CSV files will be modified."    
Write-Host "Please Drag or Add here the full-path folder :"

#Path Mandatory
param( [Parameter(Mandatory=$true)] $path)
    "directory: " + $path

#Environment variables
$DirectoryToCreate = "modified"
$Separator = 'Sep=,'
$export = $path+"\"+$DirectoryToCreate

if (-not (Test-Path -LiteralPath $DirectoryToCreate)) {
    try {
        New-Item -Path $DirectoryToCreate -ItemType Directory -ErrorAction Stop | Out-Null #-Force
    }
    catch {
        Write-Error -Message "Unable to create directory '$DirectoryToCreate'. Error was: $_" -ErrorAction Stop
    }
    "Successfully created directory '$DirectoryToCreate'."
}
else {
    "Directory already existed"
}

$files = Get-ChildItem -Path $path -Filter "*.csv"
foreach ($file in $files){
    $TempNewFile = $export + "\" + $file
    $worker = Get-Content $file
    $worker[0]="sep=,`n $($worker[0])"
    $worker | Out-File -FilePath $TempNewFile
}
