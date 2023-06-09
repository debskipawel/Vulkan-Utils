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


	-- ENGINE STATIC LIB CONFIGURATION
	project "VulkanEngine"
		kind "StaticLib"
		language "C++"
		cppdialect "C++20"
		location "src/VulkanEngine"
		targetdir "bin/%{cfg.buildcfg}"

		files { 
			"%{prj.location}/**.h", 
			"%{prj.location}/**.cpp" 
		}

		links { 
			"glfw3", 
			"vulkan-1" 
		}

		includedirs { 
			"dependencies/glm/include", 
			"dependencies/glfw/include",
			_OPTIONS["vulkan-inc"],
			"%{prj.location}"
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


	-- EXECUTABLE APP CONFIGURATION --
	project "VulkanApp"
		kind "ConsoleApp"
		language "C++"
		cppdialect "C++20"
		location "src/VulkanApp"
		targetdir "bin/%{cfg.buildcfg}"

		files { "%{prj.location}/**.h", "%{prj.location}/**.cpp" }
		links { "VulkanEngine" }
		
		includedirs { 
			"src/VulkanEngine",
			"%{prj.location}"
		}

		filter { "configurations:Debug" }
			defines { "DEBUG" }
			symbols "On"

		filter { "configurations:Release" }
			defines { "NDEBUG" }
			optimize "On"

		filter { "platforms:x64"}
			architecture "x86_64"

		filter { "platforms:x86"}
			architecture "x86"
