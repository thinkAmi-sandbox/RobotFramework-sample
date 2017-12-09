*** Settings ***
Variables    variable_file_const.py
Variables    variable_file_func.py
Variables    variable_file_class.py
Variables    variable_file_with_all.py
Variables    variable_file.yaml
# get_variables() を含むファイルを指定するとうまく動作しないこともある
# その場合はコメントアウトすること
Variables    variable_file_special_func.py


*** Test Cases ***
Pythonの定数
    log to console  ${FOO}

Pythonの辞書
    log to console  ${BAR}

Pythonの辞書でプレフィックス付
    log to console  ${BAZ}

Pythonの辞書でプレフィックス無しの場合keyアクセスができない
    log to console  ${BAR.ham}

Pythonの辞書でプレフィックス付の場合keyアクセスができる
    log to console  ${BAZ.egg}

変数が重複していた場合
    log to console  ${DUPLICATE}

Pythonの関数の結果を設定した変数
    log to console  ${RESULT}

Pythonの関数そのもの
    log to console  ${get_result}

Pythonの関数でアンダースコア始まりのものは対象外
    log to console  ${_under_score_func}

Pythonの定数で__all__にあるものは対象
    log to console  ${INCLUDE_VARIABLE}

Pythonの定数で__all__に無いものは対象外
    log to console  ${EXCLUDE_VARIABLE}

Pythonの関数で__all__にあるものは対象
    log to console  ${include_func}

Pythonの関数で__all__に無いものは対象外
    log to console  ${exclude_func}

Pythonのクラスをインスタンス化して変数に設定したものは参照できない
    log to console  ${instance_from_class}

Pythonクラスのクラス変数を使う
    log to console  ${class_val}

Pythonクラスのインスタンス変数を使う
    log to console  ${instance_val}

Pythonクラスはファイル名と同じでないとクラス変数を参照できない
    log to console  ${diff_class_val}

Pythonクラスはファイル名と同じでないとインスタンス変数を参照できない
    log to console  ${diff_instance_val}

YAMLファイルから読み込む
    log to console  ${yaml_dict}

get_variablesを使う
    log to console  ${SPECIAL_FUNC}

get_variables自体は取れない
    log to console  ${get_variables}
