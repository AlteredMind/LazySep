
# " ____________________________________________________________________________ " 
# "|                                                                            |" 
# "|                                 L A Z Y - S E P                            |" 
# "|                                                                            |" 
# "|                                 Version 2022.11                            |" 
# "|____________________________________________________________________________|" 
# "|                                                                            |" 
# "|                                   Created by                               |" 
# "|                                Matteo Ripamonti                            |" 
# "|____________________________________________________________________________|" 
# ""


#Path Mandatory
param( [Parameter(Mandatory=$true)] $path)
    "directory: " + $path


#Environment variables
$DirectoryToCreate = "modified"
$Separator = 'Sep=,'
$export = $path+"\"+$DirectoryToCreate

# if (-not (Test-Path -LiteralPath $DirectoryToCreate)) {
if (-not (Test-Path -LiteralPath $export)) {
    try {
        #New-Item -Path $DirectoryToCreate -ItemType Directory -ErrorAction Stop | Out-Null #-Force
        New-Item -Path $export -ItemType Directory -ErrorAction Stop | Out-Null #-Force
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
    $absolute = $path + "\" + $file
    $worker = Get-Content $absolute
    $worker[0]="sep=,`n $($worker[0])"
    $worker | Out-File -FilePath $TempNewFile
}
