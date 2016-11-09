# -*- coding: utf-8 -*-
"""
/***************************************************************************
 This is the place to store some global (for the Midvatten tolkning plugin) utility functions. 
 NOTE - if using this file, it has to be imported by midv_tolkn.py
                             -------------------
        begin                : 2016
        copyright            : (C) 2011 by joskal
        email                : groundwatergis [at] gmail.com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
"""
from PyQt4 import QtCore, QtGui, QtWebKit, uic
import PyQt4
from qgis.core import *
from qgis.gui import *
import csv
import codecs
import cStringIO
import difflib
import datetime
import copy
import qgis.utils
import sys
import locale
import os
import math
import numpy as np
import tempfile
from contextlib import contextmanager
from pyspatialite import dbapi2 as sqlite #must use pyspatialite since spatialite-specific sql clauses may be sent by sql_alter_db and sql_load_fr_db
from pyspatialite.dbapi2 import IntegrityError
from matplotlib.dates import datestr2num, num2date
import time
from collections import OrderedDict
import re

import midv_tolkn_defs as defs

class dbconnection(): # in use
    def __init__(self, db=''):
        self.dbpath = db
    
    def connect2db(self):
        if os.path.exists(self.dbpath):
            try:#verify this is an existing sqlite database
                self.conn = sqlite.connect(self.dbpath,detect_types=sqlite.PARSE_DECLTYPES|sqlite.PARSE_COLNAMES)
                self.conn.cursor().execute("select count(*) from sqlite_master") 
                ConnectionOK = True
            except:
                pop_up_info("Could not connect to %s"%str(self.dbpath))
                ConnectionOK = False
        else:
            pop_up_info("The file %s do not exist!"%str(self.dbpath))
            ConnectionOK = False
        return ConnectionOK
        
    def closedb(self):
            self.conn.close()

class askuser(QtGui.QDialog): # in use
    def __init__(self, question="YesNo", msg = '', dialogtitle='User input needed', parent=None):
        self.result = ''
        if question == 'YesNo':         #  Yes/No dialog 
            reply = QtGui.QMessageBox.information(parent, dialogtitle, msg, QtGui.QMessageBox.Yes | QtGui.QMessageBox.No, QtGui.QMessageBox.Yes)
            if reply==QtGui.QMessageBox.Yes:
                self.result = 1 #1 = "yes"
            else:
                self.result = 0  #0="no"
        elif question == 'AllSelected': # All or Selected Dialog
            btnAll = QtGui.QPushButton("All")   # = "0"
            btnSelected = QtGui.QPushButton("Selected")     # = "1"
            #btnAll.clicked.connect(self.DoForAll)
            #btnSelected.clicked.connect(self.DoForSelected)
            msgBox = QtGui.QMessageBox(parent)
            msgBox.setText(msg)
            msgBox.setWindowTitle(dialogtitle)
            #msgBox.setWindowModality(Qt.ApplicationModal)
            msgBox.addButton(btnAll, QtGui.QMessageBox.ActionRole)
            msgBox.addButton(btnSelected, QtGui.QMessageBox.ActionRole)
            msgBox.addButton(QtGui.QMessageBox.Cancel)
            reply = msgBox.exec_()
            self.result = reply # ALL=0, SELECTED=1
        elif question == 'DateShift':
            supported_units = [u'microseconds', u'milliseconds', u'seconds', u'minutes', u'hours', u'days', u'weeks']
            while True:
                answer = str(PyQt4.QtGui.QInputDialog.getText(None, "User input needed", "Give needed adjustment of date/time for the data.\nSupported format: +- X <resolution>\nEx: 1 hours, -1 hours, -1 days\nSupported units:\n" + ', '.join(supported_units), PyQt4.QtGui.QLineEdit.Normal, u'0 hours')[0])
                if not answer:
                    self.result = u'cancel'
                    break
                else:
                    adjustment_unit = answer.split()
                    if len(adjustment_unit) == 2:
                        if adjustment_unit[1] in supported_units:
                            self.result = adjustment_unit
                            break
                        else:
                            pop_up_info("Failure:\nOnly support resolutions\n " + ', '.join(supported_units))
                    else:
                        pop_up_info("Failure:\nMust write time resolution also.\n")

class MessagebarAndLog():
    """ Class that sends logmessages to messageBar and or to QgsMessageLog

    Usage: MessagebarAndLog.info(bar_msg='a', log_msg='b', duration=10,
    messagebar_level=QgsMessageBar.INFO, log_level=QgsMessageLog.INFO,
    button=True)

    :param bar_msg: A short msg displayed in messagebar and log.
    :param log_msg: A long msg displayed only in log.
    :param messagebar_level: The message level of the messageBar.
    :param log_level: The message level of the QgsMessageLog  { INFO = 0, WARNING = 1, CRITICAL = 2 }.
    :param duration: The duration of the messageBar.
    :param button: (True/False, default True) If False, the button to the
                   QgsMessageLog does not appear at the messageBar.

    :return:

    The message bar_msg is written to both messageBar and QgsMessageLog
    The log_msg is only written to QgsMessageLog

    * If the user only supplies bar_msg, a messageBar popup appears without button to message log.
    * If the user supplies only log_msg, the message is only written to message log.
    * If the user supplies both, a messageBar with bar_msg appears with a button to open message log.
      In the message log, the bar_msg and log_msg is written.
    """
    def __init__(self):
        pass

    @staticmethod
    def log(bar_msg=None, log_msg=None, duration=10, messagebar_level=QgsMessageBar.INFO, log_level=QgsMessageLog.INFO, button=True):
        if bar_msg is not None:
            widget = qgis.utils.iface.messageBar().createMessage(returnunicode(bar_msg))
            log_button = QtGui.QPushButton(u"View message log", pressed=show_message_log)
            if log_msg is not None and button:
                widget.layout().addWidget(log_button)
            qgis.utils.iface.messageBar().pushWidget(widget, level=messagebar_level, duration=duration)
        QgsMessageLog.logMessage(returnunicode(bar_msg), u'Midv_tolkn', level=log_level)
        if log_msg is not None:
            QgsMessageLog.logMessage(returnunicode(log_msg), u'Midv_tolkn', level=log_level)

    @staticmethod
    def info(bar_msg=None, log_msg=None, duration=10, button=True):
        MessagebarAndLog.log(bar_msg, log_msg, duration, QgsMessageBar.INFO, QgsMessageLog.INFO, button)

    @staticmethod
    def warning(bar_msg=None, log_msg=None, duration=10, button=True):
        MessagebarAndLog.log(bar_msg, log_msg, duration, QgsMessageBar.WARNING, QgsMessageLog.WARNING, button)

    @staticmethod
    def critical(bar_msg=None, log_msg=None, duration=10, button=True):
        MessagebarAndLog.log(bar_msg, log_msg, duration, QgsMessageBar.CRITICAL, QgsMessageLog.CRITICAL, button)

class UpgradeDatabase():#in use
    """
    Observera att denna uppgraderingsfunktion inte är särskilt intelligent...
    DATA_DOMÄNER:
        Den utgår från GAMLA zz_tabeller och försöker kopiera till likadana zz_tabeller i nya databasen, med kolumn-namn enligt gamla databas-formatet
    ÖVRIGA_TABELLER:
        Den utgår från NYA databas-formatet och letar efter tabeller i gamla databasen som har samma namn och sedan försöker den kopiera innehållet i de kolumner som ska finnas i nya databasen
    """
    def __init__(self,from_db,to_db,EPSG_code):
        self.export_2_splite(from_db,to_db, EPSG_code)
        
    def export_2_splite(self,source_db,target_db, EPSG_code):
        """
        Exports a datagbase to a new spatialite database file
        :param target_db: The name of the new database file
        :param source_db: The name of the source database file
        :param EPSG_code:
        :return:

        """
        conn = sqlite.connect(target_db,detect_types=sqlite.PARSE_DECLTYPES|sqlite.PARSE_COLNAMES)
        self.curs = conn.cursor()
        self.curs.execute("PRAGMA foreign_keys = ON")
        self.curs.execute(r"""ATTACH DATABASE '%s' AS a"""%source_db)
        conn.commit()#commit sql statements so far

        # first transfer data from data domains (beginning with zz_ in the database)
        dd_tables = self.curs.execute("select name from sqlite_master where name like 'zz_%'")
        d_domain_tables = [str(dd_table[0]) for dd_table in dd_tables]
        for tablename in d_domain_tables:
            self.to_sql(tablename)
        conn.commit()

        #ordered dictionary of layers with (some) data domains
        layers_dict = defs.default_layers()
        for tablename in layers_dict.keys():
            self.to_sql(tablename)
        conn.commit()

        self.curs.execute(r"""DETACH DATABASE a""")
        self.curs.execute('vacuum')

        MessagebarAndLog.info("Export done! Layers from the new database will be loaded to your qgis project")

        conn.commit()
        conn.close()

    def to_sql(self, tname):
        columns_list = self.curs.execute("""PRAGMA table_info(%s)"""%tname).fetchall()
        column_names = ', '.join([col[1] for col in columns_list]) #Load column names from sqlite table

        sql = r"insert or ignore into %s select %s from a.%s" %(tname, column_names, tname)
        try:
            self.curs.execute(sql)
        except Exception, e:
            MessagebarAndLog.critical("Export warning: sql failed. See message log.", sql + "\nmsg: " + str(e))

def find_layer(layer_name): # in use 
    for name, search_layer in QgsMapLayerRegistry.instance().mapLayers().iteritems():
        if search_layer.name() == layer_name:
            return search_layer

    return None

def getcurrentlocale():
    current_locale = QgsProject.instance().readEntry("Midvatten", "locale")[0]
    return current_locale

def pop_up_info(msg='',title='Information',parent=None):#in use
    """Display an info message via Qt box"""
    QtGui.QMessageBox.information(parent, title, '%s' % (msg))

def returnunicode(anything, keep_containers=False): #takes an input and tries to return it as unicode
    ur"""

    >>> returnunicode('b')
    u'b'
    >>> returnunicode(int(1))
    u'1'
    >>> returnunicode(None)
    u''
    >>> returnunicode([])
    u'[]'
    >>> returnunicode(['a', u'b'])
    u"[u'a', u'b']"
    >>> returnunicode(['a', 'b'])
    u"[u'a', u'b']"
    >>> returnunicode(['ä', 'ö'])
    u"[u'\\xe4', u'\\xf6']"
    >>> returnunicode(float(1))
    u'1.0'
    >>> returnunicode(None)
    u''
    >>> returnunicode([(1, ), {2: 'a'}], True)
    [(u'1',), {u'2': u'a'}]

    :param anything: just about anything
    :return: hopefully a unicode converted anything
    """
    text = None
    for charset in [u'ascii', u'utf-8', u'utf-16', u'cp1252', u'iso-8859-1']:
        try:
            if anything == None:
                text = u''
            elif isinstance(anything, list):
                text = [returnunicode(x, keep_containers) for x in anything]
            elif isinstance(anything, tuple):
                text = tuple([returnunicode(x, keep_containers) for x in anything])
            elif isinstance(anything, dict):
                text = dict([(returnunicode(k, keep_containers), returnunicode(v, keep_containers)) for k, v in anything.iteritems()])
            else:
                text = anything

            if isinstance(text, (list, tuple, dict)):
                if not keep_containers:
                    text = unicode(text)
            elif isinstance(text, str):
                text = unicode(text, charset)
            elif isinstance(text, unicode):
                pass
            else:
                text = unicode(text)

        except UnicodeEncodeError:
            continue
        except UnicodeDecodeError:
            continue
        else:
            break

    if text is None:
        try:
            text = unicode(str(anything))
        except:
            text = unicode('data type unknown, check database')
    return text

def show_message_log(pop_error=False):
    """
    Source: qgis code
     """
    if pop_error:
        qgis.utils.iface.messageBar().popWidget()

    qgis.utils.iface.openMessageLog()

def sql_load_fr_db(sql='', dbpath=''):#in use
    if os.path.exists(dbpath):
        try:
            conn = sqlite.connect(dbpath,detect_types=sqlite.PARSE_DECLTYPES|sqlite.PARSE_COLNAMES)#dbpath is unicode already #MacOSC fix1 
            curs = conn.cursor()
            resultfromsql = curs.execute(sql) #Send SQL-syntax to cursor #MacOSX fix1
            result = resultfromsql.fetchall()
            resultfromsql.close()
            conn.close()
            ConnectionOK = True
        except:
            textstring = """DB error!!"""%(sql)
            qgis.utils.iface.messageBar().pushMessage("Error",textstring, 2,duration=15) 
            ConnectionOK = False
            result = ''
    else:
        textstring = """DB error!!"""%(sql)
        qgis.utils.iface.messageBar().pushMessage("Error",textstring, 2,duration=15) 
        ConnectionOK = False
        result = ''
    return ConnectionOK, result

def sql_alter_db(dbpath,sql=''):#in use
    conn = sqlite.connect(dbpath[0],detect_types=sqlite.PARSE_DECLTYPES|sqlite.PARSE_COLNAMES)
    curs = conn.cursor()
    sql2 = sql 
    curs.execute("PRAGMA foreign_keys = ON")    #Foreign key constraints are disabled by default (for backwards compatibility), so must be enabled separately for each database connection separately.

    if isinstance(sql2, basestring):
        try:
            resultfromsql = curs.execute(sql2) #Send SQL-syntax to cursor
        except IntegrityError, e:
            raise IntegrityError("The sql failed:\n" + sql2 + "\nmsg:\n" + str(e))
    else:
        try:
            resultfromsql = curs.executemany(sql2[0], sql2[1])
        except IntegrityError, e:
            raise IntegrityError(str(e))

    result = resultfromsql.fetchall()
    conn.commit()   # This one is absolutely needed when altering a db, python will not really write into db until given the commit command
    resultfromsql.close()
    conn.close()

    return result

def write_qgs_log_to_file(message, tag, level):
    logfile = QgsLogger.logFile()
    if logfile is not None:
        QgsLogger.logMessageToFile(u'{}: {}({}): {} '.format(u'%s'%(returnunicode(get_date_time())), returnunicode(tag), returnunicode(level), u'%s'%(returnunicode(message))))
