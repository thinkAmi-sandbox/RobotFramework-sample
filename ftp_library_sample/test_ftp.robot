*** Settings ***
Library  FtpLibrary


*** Variables ***
${USER}  user
${PASSWORD}  password


*** TestCases ***
FTPサーバに接続する
    ftp connect  127.0.0.1  ${USER}  ${PASSWORD}  12345
    Mkd  foo
    # Welcome Messageを表示
    ${welcome} =  Get Welcome
    # 改行して見やすくする
    Log To Console  ${\n} ${welcome}
    # カレントディレクトリを表示
    ${path} =  Dir
    Log To Console  ${\n} ${path}
    FTP CLOSE

FTPサーバにファイルをアップロードする
    ftp connect  127.0.0.1  ${USER}  ${PASSWORD}  12345
    Mkd  upload
    Cwd  upload
    Upload File  result_google_python.png  uploaded.png
    FTP CLOSE

FTPサーバからファイルをダウンロードする
    ftp connect  127.0.0.1  ${USER}  ${PASSWORD}  12345
    # uploadディレクトリとupload.pngは前のテストで作成済なので、それを利用する
    Cwd  upload
    Download File  uploaded.png  downloaded.png
    FTP CLOSE
