*** Settings ***
Resource  variable_priorities_resource.robot


*** Variables ***

${COMMAND}  testcase_command
${VARIABLE_TABLE}  testcase_variable_table


*** Test Cases ***

ローカルで定義した変数
    ${local} =  Set Variable  local_variable
    Log To Console  ${local}

変数テーブルで定義された変数
    Log To Console  ${VARIABLE_TABLE}

importしたリソースファイルで定義された変数
    Log To Console  ${RESOURCE}

ネストしたリソースファイルで定義された変数
    Log To Console  ${NEST_RESOURCE}

コマンドラインで指定した変数
    Log To Console  ${FROM_COMMAND_LINE}


# 複数箇所で重複したテストケース
コマンドラインと変数テーブルとリソースファイルで重複した変数
    Log To Console  ${COMMAND}

変数テーブルとリソースファイルで重複した変数
    Log To Console  ${VARIABLE_TABLE}

リソースファイルのimport元と先で重複した変数
    Log To Console  ${RESOURCE_IMPORT}

リソースファイルのみの変数をこのテストケースだけで上書きした場合
    Set Test Variable  ${RESOURCE}  adohoc
    Log To Console  ${RESOURCE}
