*** Settings ***
Library  String


*** Keywords ***

0から9のランダムな文字列を取得する
    ${random} =  Generate Random String  length=1  chars=[NUMBERS]
    [Return]  ${random}


Set Variable If の書き方
    [Arguments]  ${random}
    ${result} =  Set Variable If  ${random} == 0  ${\n}Zero
    ...          ${random} == 1  ${\n}One
    # ELSEの場合は、"ELSE"という文字列や条件式が不要
    ...          ${\n}Other

    Log To Console  ${result}


Run Keyword If の書き方
    [Arguments]  ${random}
    Run Keyword If  ${random} == 0  Log To Console  Zero
    ...  ELSE IF    ${random} == 1  Log To Console  One
    ...  ELSE  Log To Console  Other


*** Test Cases ***

Set Variable IfとRun Keyword If の違い
    ${random} =  0から9のランダムな文字列を取得する
    Set Variable If の書き方  random=${random}
    Run Keyword If の書き方  random=${random}

