#!/usr/local/bin/python
import os

#################DB SETTINGS######################
db_port = os.environ.get('DB_PORT', default=5432)
db_host = os.environ.get('DB_HOST')
db_name = os.environ.get('DB_NAME')
db_user = os.environ.get('DB_USERNAME')
db_password = os.environ.get('DB_PASSWORD')

################SQLALCHEMY SETTINGS###############
db_string = 'postgresql://{user}:{pw}@{host}/{db}'.format(user=db_user,pw=db_password,host=db_host,db=db_name)
SQLALCHEMY_TRACK_MODIFICATIONS = False
SQLALCHEMY_ECHO = True
