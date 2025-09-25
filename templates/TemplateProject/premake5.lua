project "<ProjectName>"
    language "C++"
    cppdialect "C++latest"
	kind "<AppType>"
		
    targetdir 	("%{wks.location}/bin/%{prj.name}/" .. outputDir)
    objdir 		("%{wks.location}/obj/%{prj.name}/" .. outputDir)

    files 
    { 
        "src/**.h", 
        "src/**.cpp",
    }
	
	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

    includedirs
    {
        "%{IncludeDir.<ProjectName>}",
        "%{IncludeDir.StreamlineCore}",
        "%{IncludeDir.glm}",
        "%{IncludeDir.imgui}",
        "%{IncludeDir.json}",
        "%{IncludeDir.magic_enum}",
    }

	links
	{
		"StreamlineCore",
	}
	
    filter "system:windows"
        staticruntime "off"
        systemversion "latest"
		
	filter "system:linux"
        staticruntime "off"
        pic "On"
        systemversion "latest"

    filter "configurations:Debug"
		runtime "Debug"
        symbols "on"
    filter "configurations:Release"
		runtime "Release"
        optimize "on"
    filter "configurations:Profile"
		runtime "Release"
        optimize "on"