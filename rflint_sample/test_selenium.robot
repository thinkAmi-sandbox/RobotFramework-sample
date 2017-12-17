*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome

*** Keywords ***
ブラウザを起動する
    Open Browser  https://google.co.jp  ${browser}

*** Test Cases ***
Seleniumをテストする
    ブラウザを起動する
    Close Browser
