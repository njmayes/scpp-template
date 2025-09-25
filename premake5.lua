workspace "scpp-template"
    startproject "<ProjectName>"

    configurations 
    { 
        "Debug",
        "Release",
		"Profile",
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
OPENSSL_ROOT = os.getenv("OPENSSL_ROOT_DIR")

outputDir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}

LibraryDir = {}
Library = {}

IncludeDir["StreamlineCore"] 	= "%{wks.location}/dependencies/streamline-cpp/StreamlineCore/src"
IncludeDir["asio"] 	            = "%{wks.location}/dependencies/streamline-cpp/StreamlineCore/dependencies/asio/include"
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

Library["asio"] 				= "asio"
Library["glad"] 				= "glad"
Library["glfw"] 				= "glfw"
Library["imgui"] 				= "imgui"

filter "system:windows"
    LibraryDir["VulkanSDK"] 	= "%{VULKAN_SDK}/Lib"
    IncludeDir["OpenSSL"]       = "%{OPENSSL_ROOT}/include"

group "Dependencies"

include "dependencies/streamline-cpp/StreamlineCore"
include "dependencies/streamline-cpp/StreamlineCore/dependencies/asio"
include "dependencies/streamline-cpp/StreamlineCore/dependencies/glfw"
include "dependencies/streamline-cpp/StreamlineCore/dependencies/glad"
include "dependencies/streamline-cpp/StreamlineCore/dependencies/imgui"

group ""
