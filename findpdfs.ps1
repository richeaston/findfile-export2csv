$array = @()

$files = Get-ChildItem -Filter "*.pdf" -Path C: -Recurse | select Name, Fullname, Lastaccesstime

foreach ($file in $files) {
    $acl = get-acl $file.fullname | Select -ExpandProperty Owner
    
    $output = [PScustomobject]@{
        acl = $acl
        name = $file.Name
        path = $file.FullName
        lastaccessed = $file.LastAccessTime
    }
    $array += $output
}

$array | Sort-object Name

$array | Export-Csv "D:\pdfs.csv" -force -NoClobber -NoTypeInformation
