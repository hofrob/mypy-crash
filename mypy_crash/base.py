import datetime
import functools
import logging
import typing

import flask_sqlalchemy
import sqlalchemy
from sqlalchemy import event, orm
from sqlalchemy.ext import declarative

db: flask_sqlalchemy.SQLAlchemy = flask_sqlalchemy.SQLAlchemy()
Base = declarative.declarative_base()


class Model(Base):
    __abstract__ = True
    id: int = sqlalchemy.Column(sqlalchemy.Integer, primary_key=True)
