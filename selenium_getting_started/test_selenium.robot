*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${検索キーワード}  SeleniumLibrary


*** Keywords ***
Chromeを起動する
    Open Browser  https://google.co.jp  Chrome


*** TestCases ***
GoogleでSeleniumLibraryを検索するテスト
    Open Browser  https://google.co.jp  Chrome
    Input Text  name=q  SeleniumLibrary
    Press Key  name=q  \\13
    # 結果出力と検証
    ${links} =  Get Webelements  css=h3 > a
    :For  ${link}  In  @{links}
        \  ${text} =  Get Text  ${link}
        \  Log To Console  ${text}
    Length Should Be  ${links}  10
    Close Browser


GoogleでSeleniumLibraryを検索するテスト2
    Chromeを起動する
    Input Text  name=q  ${検索キーワード}
    Press Key  name=q  \\13
    # 結果出力と検証
    ${links} =  Get Webelements  css=h3 > a
    :For  ${link}  In  @{links}
        \  ${text} =  Get Text  ${link}
        \  Log To Console  ${text}
    Length Should Be  ${links}  10
    Close Browser
