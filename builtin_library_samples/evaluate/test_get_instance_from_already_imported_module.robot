*** Settings ***
Library  SeleniumLibrary
Library  DebugLibrary

*** TestCases ***
読み込み済モジュールに含まれるクラスをインスタンス化する
    ${options} =  Evaluate  sys.modules['selenium.webdriver.firefox.options'].Options()  sys
    Debug

