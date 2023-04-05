#if env variable VULKAN_PATH not set to Vulkan location
if ($null -EQ $env:VULKAN_PATH)
{
    $mainDirectoryName = "VulkanSDK";

    Write-Output "Searching for Vulkan instalation directory...";
    Write-Output "";

    # recursively search for a directory named $mainDirectoryName ('VulkanSDK')
    $vulkanPath = Get-ChildItem C:\ -Recurse -Depth 3 -Filter $mainDirectoryName -Force -Directory -ErrorAction SilentlyContinue | Select-Object -First 1 | ForEach-Object {$_.FullName};

    if ($null -eq $vulkanPath)
    {
        Write-Output "[ERROR] Couldn't find Vulkan directory.";
        Exit;
    }

    Write-Output "Vulkan directory found!";
    Write-Output "Searching for latest version...";
    Write-Output "";

    # list all subdirectories named with version numbers (regex match) and choose the latest version
    $vulkanVersions = Get-ChildItem $vulkanPath -Directory | Where-Object{$_.Name -Match '^\d+[\.\d+]+$'} | Sort-Object -Descending;
    $vulkanLatestVersionPath = $vulkanVersions | Select-Object -First 1 | ForEach-Object {$_.FullName};

    if ($null -eq $vulkanLatestVersionPath)
    {
        Write-Output "[ERR] No Vulkan location found.";
        Exit;
    }

    Write-Output @([string]::Format("Latest version found at: {0}", $vulkanLatestVersionPath));
    Write-Output "Testing if all necessary directories in place...";
    Write-Output "";

    $env:VULKAN_PATH = $vulkanLatestVersionPath;
}

# create paths to include and lib directories and check if they exist
$vulkanIncPath = [string]::Format("{0}\Include\", $env:VULKAN_PATH);
$vulkanLibPath = [string]::Format("{0}\Lib\", $env:VULKAN_PATH);

if (-NOT (Test-Path -Path $vulkanIncPath,$vulkanLibPath))
{
    Write-Output @([string]::Format("[ERROR] Vulkan installed incorrectly or script is outdated. Check Vulkan at: ", $vulkanLatestVersionPath));
    Exit;
}

Write-Output "Success, generating project files..."
Write-Output "";

# generate project files using premake
$premakeResponse = premake5 vs2022 --vulkan-inc="$vulkanIncPath" --vulkan-lib="$vulkanLibPath";

if (($premakeResponse -MATCH '^Error:') -OR ($premakeResponse.Length -EQ 0) -OR -NOT ($premakeResponse[$premakeResponse.Length - 1] -MATCH '^Done \([1-9][0-9]*ms\).$'))
{
    Write-Output "[ERROR] Project files not generated correctly.";
    Write-Output "Log dump from premake:"
    $premakeResponse | ForEach-Object { "`t $_" }
    Exit;
}

Write-Output "Project files generated successfully!"
