

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

#for-each files  (*.CSV) in folder -> add line on top
#Get-ChildItem $path -Filter "*.csv" | foreach {$TextToAdd+"`n" + (get-content $_) | Out-File $_;  Move-Item -Path $_ -Destination $NewPath}

