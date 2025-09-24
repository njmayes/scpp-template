import os
import platform
import requests
from pathlib import Path
import Common

if platform.system() == "Windows":
    import UtilsWindows as Utils
elif platform.system() == "Linux":
    import UtilsLinux as Utils
else:
    raise ImportError("Unsupported platform")

def GetLatestPremakeVersion():
    LATEST_ENTRY = 0
    TAG_FIELD = "tag_name"
    url = "https://api.github.com/repos/premake/premake-core/releases"
    headers = {
        'Accept': 'application/vnd.github.v3+json'
    }
    response = requests.request("GET", url, headers = headers)
    if (response.status_code != 200) :
        return "5.0.0-beta2" # default if lookup fails
    return response.json()[LATEST_ENTRY][TAG_FIELD][1:] # Strip 'v' character out of tag name. Ex: v5.0.0-beta2 -> 5.0.0-beta2

    
class PremakeConfiguration:

    if platform.system() == "Windows":
        premakeSuffix = "windows.zip"
        premakeExtension = ".exe"
        premakeFilters = [premakeExtension]
    elif platform.system() == "Linux":
        premakeSuffix = "linux.tar.gz"
        premakeExtension = ""
        premakeFilters = [premakeExtension]
    else:
        premakeSuffix = ""
        premakeExtension = ""
        premakeFilters = []
        
    premakeVersion = GetLatestPremakeVersion()
    premakeBinaryUrls = f"https://github.com/premake/premake-core/releases/download/v{premakeVersion}/premake-{premakeVersion}-{premakeSuffix}"
    premakeLicenseUrl = "https://raw.githubusercontent.com/premake/premake-core/master/LICENSE.txt"
    premakeDirectory = "./dependencies/premake/bin"

    @classmethod
    def Validate(cls):
        if (not cls.CheckIfPremakeInstalled()):
            print("Premake is not installed.")
            return False

        print(f"Correct Premake located at {os.path.abspath(cls.premakeDirectory)}")
        return True

    @classmethod
    def CheckIfPremakeInstalled(cls):
        premakeBinary = Path(f"{cls.premakeDirectory}/premake5{cls.premakeExtension}");
        if (not premakeBinary.exists()):
            return cls.InstallPremake()

        return True

    @classmethod
    def InstallPremake(cls):
        def InstallJob():
            premakePath = f"{cls.premakeDirectory}/premake-{cls.premakeVersion}-{cls.premakeSuffix}"
            print("Downloading {0:s} to {1:s}".format(cls.premakeBinaryUrls, premakePath))
            Utils.DownloadFile(cls.premakeBinaryUrls, premakePath)
            print("Extracting", premakePath)
            Utils.UnpackFile(premakePath, cls.premakeFilters, True)
            print(f"Premake {cls.premakeVersion} has been downloaded to '{cls.premakeDirectory}'")

            premakeLicensePath = f"{cls.premakeDirectory}/LICENSE.txt"
            print("Downloading {0:s} to {1:s}".format(cls.premakeLicenseUrl, premakeLicensePath))
            Utils.DownloadFile(cls.premakeLicenseUrl, premakeLicensePath)
            print(f"Premake License file has been downloaded to '{cls.premakeDirectory}'")

        return Common.PromptUserForTask("Premake not found. Would you like to download Premake {0:s}? [Y/N]: ".format(cls.premakeVersion), InstallJob )