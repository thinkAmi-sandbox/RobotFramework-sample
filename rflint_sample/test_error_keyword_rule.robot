*** Settings ***
Documentation  カスタムキーワードルール違反


*** Keywords ***
ふー
    Log To Console  baz

ふーー
    Log To Console  hoo

*** Test Cases ***
一つのファイルでテストケース名が重複
    ふー
