import json
from sqlalchemy import create_engine
from sqlalchemy import Column, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from config import *

db = create_engine(db_string)  
base = declarative_base()

class App(base):  
    __tablename__ = 'app'

    name = Column(String, primary_key=True)
    data = Column(String)

Session = sessionmaker(db)  
session = Session()

base.metadata.create_all(db)

def datacheck():
  exists = session.query(App).filter_by(name="check").first()
  if not exists:
    hello_world = App(name="check", data="Hello World")  
    session.add(hello_world)
    session.commit()
