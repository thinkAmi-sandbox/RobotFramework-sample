# -*- coding: utf-8 -*-

import os
from bottle import route, get, run, static_file, TEMPLATE_PATH

# jinja2テンプレートを使う場合、bottleのjinaj2_template関数を使う
from bottle import jinja2_template

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
TEMPLATE_PATH.append(os.path.join(BASE_DIR, 'views'))
STATIC_DIR = os.path.join(BASE_DIR, 'static')


@get('/')
def index():
    return jinja2_template('index')


# BottleのWildcard Filterを使うことで、サブディレクトリも探してくれる
# https://bottlepy.org/docs/dev/routing.html
@route('/static/<filename:path>')
def send_images(filename):
    # http://bottlepy.org/docs/dev/tutorial.html#tutorial-static-files
    return static_file(filename, root=STATIC_DIR)


if __name__ == "__main__":
    run(host="localhost", port=8084, debug=True, reloader=True)
