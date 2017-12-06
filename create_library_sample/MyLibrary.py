from robot.api import logger


def hello_world(key='default'):
    logger.console(f'{key} de hello world')


def ハロー_ワールド(key='デフォルト'):
    logger.console(f'{key} を使ったハローワールド')
