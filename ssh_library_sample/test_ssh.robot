*** Settings ***
Library  SSHLibrary

*** Variables ***
${user}  root
${password}  screencast

*** Test Cases ***
パスワードでログインしてhelloする
    Open Connection  localhost  port=12345
    Login  root  screencast
    ${output} =  Execute Command  echo Hello SSHLibrary with password!
    Log To Console  ${\n}${output}
    Should Be Equal  ${output}  Hello SSHLibrary with password!
    Close All Connections

公開鍵でログインしてhelloする
    Open Connection  localhost  port=12345
    # 鍵は秘密鍵を指定する
    Login With Public Key  root  id_rsa_sshlibrary_sample  screencast
    ${output} =  Execute Command  echo Hello SSHLibrary with public key!
    Log To Console  ${\n}${output}
    Should Be Equal  ${output}  Hello SSHLibrary with public key!
    Close All Connections
