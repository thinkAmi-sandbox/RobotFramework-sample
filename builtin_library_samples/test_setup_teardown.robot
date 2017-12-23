*** Keywords ***
セットアップキーワードをまとめた
    Log To Console  ${\n}セットアップ1です
    Log To Console  セットアップ2です

ティアダウンキーワードをまとめた
    Log To Console  ティアダウン1です
    Log To Console  ティアダウン2です


*** Test Cases ***

SetupとTeardownのキーワードを1つにした場合
    [Setup]  Log To Console  ${\n}セットアップです
    [Teardown]  Log To Console  ティアダウンです
    Log To Console  テスト本体です


SetupとTeardownのキーワードを2つにした場合
    [Setup]  Log To Console  ${\n}セットアップ1です  Log To Console  セットアップ2です
    [Teardown]  Log To Console  ティアダウン1です  Log To Console  ティアダウン2です
    Log To Console  テスト本体です


SetupとTeardownのキーワードを1つにまとめた場合
    [Setup]  セットアップキーワードをまとめた
    [Teardown]  ティアダウンキーワードをまとめた
    Log To Console  テスト本体です


SetupとTeardownのキーワードをRun Keywordsで複数同時に起動した場合
    # Run Keywordsでキーワードに引数がある場合は、明示的に `AND` を使う必要がある
    # http://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Run%20Keywords
    [Setup]  Run Keywords  Log To Console  ${\n}セットアップ1です  AND  Log To Console  セットアップ2です
    [Teardown]  Run Keywords  Log To Console  ティアダウン1です  AND  Log To Console  ティアダウン2です
    Log To Console  テスト本体です
