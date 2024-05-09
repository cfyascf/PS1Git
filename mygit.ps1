param(
    [string] $init = "", 
    [string] $add = "",
    [string] $commit = "",
    [string] $clsadd = ""
)

[string] $currentpath = (Get-Location).Path
[string] $repository = ".mygit"
[string] $repositorypath = "$currentpath/$repository"
[string] $addfile = "add.txt"

function init {
    param(
        [string] $filename = "filename"
    )

    New-Item -Path $currentpath -Name $repository -ItemType Directory
    New-Item -Path $repositorypath -Name $addfile -ItemType File
    Write-Host "Repository initiated with success :)"
}

function  add {
    param (
        [string] $file = "file.ext"
    )
    [string] $filepath = "$repositorypath/$addfile"
    [string[]]$files = Get-ChildItem -Path $currentpath
    [int] $filexists = 0

    if($file -eq ".") {
        foreach ($f in $files) {
            if($f -ne "add.txt" -and $f -ne "mygit.ps1" -and $f -ne ".mygit") {
                $f | Out-File -FilePath $filepath -Append
            }
        }
        Write-Host "All files from folder added with success :)"
        return
    }
    
    foreach ($f in $files) {
        if($f -eq $file) {
            $filexists = 1
        }
    }

    if($filexists -eq 1) {
        $file | Out-File -FilePath $filepath -Append
        Write-Host "File added with success :)"
    } else {
        Write-Host "File does not exist :\"
    }
}

function commit {
    param (
        [string] $n = "repository name"
    )

    [string[]] $addfiles = Get-Content -Path "$repositorypath/$addfile"
    [string[]] $gitfiles = Get-ChildItem -Path $repositorypath
    
    foreach($f in $gitfiles) {
        if($f -eq $n) {
            Write-Host "File name already exists :\"
            return
        }
    }
    
    New-Item -Path $repositorypath -Name $n -ItemType Directory 

    foreach ($f in $addfiles) {
        $filepath = "$currentpath/$f"
        Copy-Item $filepath -Destination "$repositorypath/$n" 
    }

    Clear-Content "$repositorypath/$addfile"
    Write-Host "Repository committed with success :)"
}

function clsadd {
    param (
        [string] $r = "recursive"
    )

    Clear-Content "$repositorypath/$addfile"
    Write-Host "Add file cleared with success :)"
}

if(($init -ne "") -and ($add -eq "") -and ($commit -eq "") -and ($clsadd -eq "")) {
    init -path $init

} elseif(($init -eq "") -and ($add -ne "") -and ($commit -eq "") -and ($clsadd -eq "")) {
    add -file $add
} elseif(($init -eq "") -and ($add -eq "") -and ($commit -ne "") -and ($clsadd -eq "")) {
    commit -n $commit
}
elseif(($init -eq "") -and ($add -eq "") -and ($commit -eq "") -and ($clsadd -ne "")) {
    clsadd -r $clsadd
}







