# Vulkan Utils

A simple console app project made to help the user jump instantly into Vulkan development, without forcing them to manually link all the dependencies and hard-code the path to Vulkan SDK. After generating project files, GLM, GLFW & Vulkan are automatically linked.
___

## Requirements

The PowerShell script uses `premake` to generate project files, so it needs to be downloaded from [HERE](https://premake.github.io/download). Binaries, whether compiled from source or downloaded, need to be placed in a directory added to `$PATH`.

Also, VulkanSDK needs to be downloaded and installed on `C:` drive. If it's located somewhere else, PowerShell script needs to be modified on line 10. After executing, script will automatically find the location of Vulkan's latest version and generate project files with it automatically linked.
