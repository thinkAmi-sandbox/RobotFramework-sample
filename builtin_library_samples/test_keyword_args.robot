*** Keywords ***
埋め込みキーワード「${embed}」のみ
    log to console  ${embed}

Argumentsのみ
    [Arguments]  ${arg}
    log to console  ${arg}

キーワード「${embed}」とArgumentsの両方
    [Arguments]  ${arg}
    log to console  ${embed}
    log to console  ${arg}


*** Test Cases ***

埋め込み引数のみのキーワードを使う
    埋め込みキーワード「埋め込み」のみ

Arguments設定がある引数のみのキーワードを使う
    Argumentsのみ  arg=Argument設定

両方の引数を使う
    キーワード「埋め込み」とArgumentsの両方  arg=Argument設定
