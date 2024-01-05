workspace "scpp-template"
    startproject "TemplateProject"

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

outputDir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["TemplateProject"] 	= "%{wks.location}/TemplateProject/src"
IncludeDir["StreamlineCore"] 	= "%{wks.location}/TemplateProject/dependencies/streamline-cpp/StreamlineCore/src"
IncludeDir["glfw"] 	            = "%{wks.location}/TemplateProject/dependencies/streamline-cpp/StreamlineCore/dependencies/glfw/include"
IncludeDir["glad"] 	            = "%{wks.location}/TemplateProject/dependencies/streamline-cpp/StreamlineCore/dependencies/glad/include"
IncludeDir["imgui"] 	        = "%{wks.location}/TemplateProject/dependencies/streamline-cpp/StreamlineCore/dependencies/imgui"

include "TemplateProject"

group "Dependencies"

include "TemplateProject/dependencies/streamline-cpp/StreamlineCore"
include "TemplateProject/dependencies/streamline-cpp/StreamlineCore/dependencies/glfw"
include "TemplateProject/dependencies/streamline-cpp/StreamlineCore/dependencies/glad"
include "TemplateProject/dependencies/streamline-cpp/StreamlineCore/dependencies/imgui"

group ""