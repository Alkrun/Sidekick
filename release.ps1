$version = dotnet gitversion | ConvertFrom-Json

$gitToolVersion = "5.1.4-beta1.41";

if($LASTEXITCODE -ne 0) {
    Write-Warning "Error determining version, is gitversion.tool installed? 'dotnet tool install -g gitversion.tool --version $gitToolVersion'"
    throw "Error determining version: $LASTEXITCODE";
}

$tag = "v$($version.SemVer)"

Write-Output "Tagging release as $tag";

git tag $tag;
if($LASTEXITCODE -ne 0) {
    throw "Error setting git tag: $tag - $LASTEXITCODE";
}
git push --tags;
if($LASTEXITCODE -ne 0) {
    throw "Error pushing git tag: $tag - $LASTEXITCODE";
}
