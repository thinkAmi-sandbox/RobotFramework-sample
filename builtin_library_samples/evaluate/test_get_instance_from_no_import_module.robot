*** Settings ***
Library  DebugLibrary

*** TestCases ***
sys.modules()でインスタンス化する
    ${version} =  Evaluate  sys.modules['distutils.version'].LooseVersion('3.0.2')  sys,distutils.version
    Log To Console  ${\n}${version}
    Debug

__import__()でインスタンス化する
    ${version} =  Evaluate  importlib.import_module('distutils.version').LooseVersion('3.0.2')  importlib
    Log To Console  ${\n}${version}
    Debug

importlib.import_module()でインスタンス化する
    ${version} =  Evaluate  importlib.import_module('distutils.version').LooseVersion('3.0.2')  importlib
    Log To Console  ${\n}${version}
    Debug
