import sys
import os
import platform
import subprocess
import shutil
import configparser
from unicodedata import name
import requests
from pathlib import Path

def ReplaceNamespace(namespace):
    with open('premake5.lua', 'r') as premakeRoot:
        filedata = premakeRoot.read()
    filedata = filedata.replace('scpp-template', namespace)
    with open('premake5.lua', 'w') as premakeRoot:
        premakeRoot.write(filedata)

def ReplaceProjectName(projectName):
    with open('premake5.lua', 'r') as premakeRoot:
        filedata = premakeRoot.read()
    filedata = filedata.replace('TemplateProject', projectName)
    with open('premake5.lua', 'w') as premakeRoot:
        premakeRoot.write(filedata)
        
    with open('{name}/premake5.lua'.format(name=projectName), 'r') as premakeProj:
        filedata = premakeProj.read()
    filedata = filedata.replace('TemplateProject', projectName)
    with open('{name}/premake5.lua'.format(name=projectName), 'w') as premakeProj:
        premakeProj.write(filedata)
        
def CheckForStreamlineSubmodule():
    gitmodules = Path(".gitmodules")
    if not gitmodules.exists():
        return False
        
    parser = configparser.ConfigParser()
    parser.optionxform = str  # preserve case
    parser.read(gitmodules)
    
    for section in parser.sections():
        if section.startswith('submodule '):
            sub_path = parser.get(section, 'path', fallback=None)
            if sub_path == path:
                return True
    return False
    
class ProjectConfiguration:

    @classmethod
    def SetupStreamlineDependency(cls):
        if not CheckForStreamlineSubmodule():
            subprocess.call(['git', 'submodule', 'add', 'https://github.com/amayesingnathan/streamline-cpp.git', 'dependencies/streamline-cpp'])
        subprocess.call(['git', 'submodule', 'update', '--init', '--recursive'])

    @classmethod
    def CheckProjectConfig(cls):
        return not os.path.isdir('TemplateProject')

    @classmethod
    def SetupNamespace(cls, namespace):
        ReplaceNamespace(namespace)
        
    @classmethod
    def SetupProject(cls, projectName):        
        os.rename('TemplateProject', projectName)
        ReplaceProjectName(projectName)