newoption {
	trigger = "vulkan-inc",
	value = "path",
	description = "Path to Vulkan include catalog"
}

newoption {
	trigger = "vulkan-lib",
	value = "path",
	description = "Path to Vulkan lib catalog"
}


workspace "VulkanSln"
	configurations { "Debug", "Release" }
	platforms { "x64", "x86" }
	

project "glm"
	kind "StaticLib"
	language "C++"
	location "dependencies/glm/"

	files { "include/**.hpp" }


project "VulkanApp"
	kind "ConsoleApp"
	language "C++"
	location "src/VulkanApp"
    targetdir "bin/%{cfg.buildcfg}"

	files { "%{prj.location}/**.h", "%{prj.location}/**.cpp" }
	links { "glfw3", "vulkan-1" }
	
	includedirs { 
		"dependencies/glm/include", 
		"dependencies/glfw/include",
		_OPTIONS["vulkan-inc"]
	}

	filter { "configurations:Debug" }
    	defines { "DEBUG" }
    	symbols "On"

	filter { "configurations:Release" }
    	defines { "NDEBUG" }
    	optimize "On"
	
	filter { "platforms:x64"}
		architecture "x86_64"
		libdirs { 
			"dependencies/glfw/lib/x64", 
			_OPTIONS["vulkan-lib"] 
		}

	filter { "platforms:x86"}
		architecture "x86"
		libdirs { 
			"dependencies/glfw/lib/x86", 
			_OPTIONS["vulkan-lib"] 
		}
