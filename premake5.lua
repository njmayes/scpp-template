workspace "scpp-template"
    startproject "<ProjectName>"

    configurations 
    { 
        "Debug",
        "Release"
    }
    
    platforms
    {
        "x64",
        "ARM32",
        "ARM64"
    }

	filter "platforms:x64"
		architecture "x86_64"

	filter "platforms:ARM32"
		architecture "ARM"

 	filter "configurations:ARM64"
		architecture "ARM64"

VULKAN_SDK = os.getenv("VULKAN_SDK")

outputDir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["StreamlineCore"] 	= "%{wks.location}/dependencies/streamline-cpp/StreamlineCore/src"
IncludeDir["glfw"] 	            = "%{wks.location}/dependencies/streamline-cpp/StreamlineCore/dependencies/glfw/include"
IncludeDir["glad"] 	            = "%{wks.location}/dependencies/streamline-cpp/StreamlineCore/dependencies/glad/include"
IncludeDir["glm"] 				= "%{wks.location}/dependencies/streamline-cpp/StreamlineCore/dependencies/glm"
IncludeDir["imgui"] 	        = "%{wks.location}/dependencies/streamline-cpp/StreamlineCore/dependencies/imgui"
IncludeDir["ImGuizmo"] 			= "%{wks.location}/dependencies/streamline-cpp/StreamlineCore/dependencies/ImGuizmo"
IncludeDir["json"] 			    = "%{wks.location}/dependencies/streamline-cpp/StreamlineCore/dependencies/json"
IncludeDir["magic_enum"] 		= "%{wks.location}/dependencies/streamline-cpp/StreamlineCore/dependencies/magic_enum"
IncludeDir["pfd"] 				= "%{wks.location}/dependencies/streamline-cpp/StreamlineCore/dependencies/portable-file-dialogs"
IncludeDir["stb_image"] 		= "%{wks.location}/dependencies/streamline-cpp/StreamlineCore/dependencies/stb_image"
IncludeDir["VulkanSDK"] 		= "%{VULKAN_SDK}/Include"

LibraryDir = {}
LibraryDir["VulkanSDK"] 		 	= "%{VULKAN_SDK}/Lib"

Library = {}

Library["Vulkan"] 					= "%{LibraryDir.VulkanSDK}/vulkan-1.lib"
Library["VulkanUtils"] 				= "%{LibraryDir.VulkanSDK}/VkLayer_utils.lib"

Library["ShaderC_Debug"] 			= "%{LibraryDir.VulkanSDK}/shaderc_sharedd.lib"
Library["SPIRV_Cross_Debug"] 		= "%{LibraryDir.VulkanSDK}/spirv-cross-cored.lib"
Library["SPIRV_Cross_GLSL_Debug"]	= "%{LibraryDir.VulkanSDK}/spirv-cross-glsld.lib"
Library["SPIRV_Tools_Debug"] 		= "%{LibraryDir.VulkanSDK}/SPIRV-Toolsd.lib"

Library["ShaderC_Release"] 			= "%{LibraryDir.VulkanSDK}/shaderc_shared.lib"
Library["SPIRV_Cross_Release"] 		= "%{LibraryDir.VulkanSDK}/spirv-cross-core.lib"
Library["SPIRV_Cross_GLSL_Release"] = "%{LibraryDir.VulkanSDK}/spirv-cross-glsl.lib"

group "Dependencies"

include "dependencies/streamline-cpp/StreamlineCore"
include "dependencies/streamline-cpp/StreamlineCore/dependencies/glfw"
include "dependencies/streamline-cpp/StreamlineCore/dependencies/glad"
include "dependencies/streamline-cpp/StreamlineCore/dependencies/imgui"

group ""
