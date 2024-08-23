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
import datetime
import os
import sqlite3
from collections import OrderedDict

import qgis.utils
from qgis.PyQt.QtCore import QCoreApplication
from qgis.PyQt.QtWidgets import QDialog, QMessageBox, QPushButton, QLineEdit, QInputDialog
from qgis.core import QgsLogger, QgsProject, Qgis, QgsApplication
from qgis.utils import spatialite_connect

from . import midv_tolkn_defs as defs


class dbconnection(): # in use
    def __init__(self, db=''):
        self.dbpath = db
    
    def connect2db(self):
        if os.path.exists(self.dbpath):
            try:#verify this is an existing sqlite database
                self.conn = spatialite_connect(self.dbpath,detect_types=sqlite3.PARSE_DECLTYPES|sqlite3.PARSE_COLNAMES)
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

class Askuser(QDialog):
    def __init__(self, question="YesNo", msg = '', dialogtitle='User input needed', parent=None):
        self.result = ''
        if question == 'YesNo':         #  Yes/No dialog
            reply = QMessageBox.information(parent, dialogtitle, msg, QMessageBox.Yes | QMessageBox.No, QMessageBox.Yes)
            if reply==QMessageBox.Yes:
                self.result = 1 #1 = "yes"
            else:
                self.result = 0  #0="no"
        elif question == 'AllSelected': # All or Selected Dialog
            btnAll = QPushButton("All")   # = "0"
            btnSelected = QPushButton("Selected")     # = "1"
            #btnAll.clicked.connect(lambda x: self.DoForAll())
            #btnSelected.clicked.connect(lambda x: self.DoForSelected())
            msgBox = QMessageBox(parent)
            msgBox.setText(msg)
            msgBox.setWindowTitle(dialogtitle)
            #msgBox.setWindowModality(Qt.ApplicationModal)
            msgBox.addButton(btnAll, QMessageBox.ActionRole)
            msgBox.addButton(btnSelected, QMessageBox.ActionRole)
            msgBox.addButton(QMessageBox.Cancel)
            reply = msgBox.exec_()
            self.result = reply  # ALL=0, SELECTED=1
        elif question == 'DateShift':
            supported_units = ['microseconds', 'milliseconds', 'seconds', 'minutes', 'hours', 'days', 'weeks']
            while True:
                answer = str(QInputDialog.getText(None, "User input needed", "Give needed adjustment of date/time for the data.\nSupported format: +- X <resolution>\nEx: 1 hours, -1 hours, -1 days\nSupported units:\n%s"%', '.join(supported_units), QLineEdit.Normal, '0 hours')[0])
                if not answer:
                    self.result = 'cancel'
                    break
                else:
                    adjustment_unit = answer.split()
                    if len(adjustment_unit) == 2:
                        if adjustment_unit[1] in supported_units:
                            self.result = adjustment_unit
                            break
                        else:
                            pop_up_info("Failure:\nOnly support resolutions\n%s"%', '.join(supported_units))
                    else:
                        pop_up_info("Failure:\nMust write time resolution also.\n")


class MessagebarAndLog(object):
    """ Class that sends logmessages to messageBar and or to QgsMessageLog

    Usage: MessagebarAndLog.info(bar_msg='a', log_msg='b', duration=10,
    messagebar_level=Qgis.Info, log_level=Qgis.Info,
    button=True)

    :param bar_msg: A short msg displayed in messagebar and log.
    :param log_msg: A long msg displayed only in log.
    :param messagebar_level: The message level of the messageBar.
    :param log_level: The message level of the QgsMessageLog  { Info = 0, Warning = 1, Critical = 2 }.
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

      Activate writing of log messages to file by settings :
      qgis Settings > Options > System > Environment > mark Use custom variables > Click Add >
      enter "QGIS_LOG_FILE" in the field Variable and a filename as Value.
    """
    def __init__(self):
        pass

    @staticmethod
    def log(bar_msg=None, log_msg=None, duration=10, messagebar_level=Qgis.Info, log_level=Qgis.Info, button=True):
        if qgis.utils.iface is None:
            return None
        if bar_msg is not None:
            widget = qgis.utils.iface.messageBar().createMessage(returnunicode(bar_msg))
            log_button = QPushButton(QCoreApplication.translate('MessagebarAndLog', "View message log"), pressed=show_message_log)
            if log_msg is not None and button:
                widget.layout().addWidget(log_button)
            qgis.utils.iface.messageBar().pushWidget(widget, level=messagebar_level, duration=duration)
            #This part can be used to push message to an additional messagebar, but dialogs closes after the timer
            if hasattr(qgis.utils.iface, 'optional_bar'):
                try:
                    qgis.utils.iface.optional_bar.pushWidget(widget, level=messagebar_level, duration=duration)
                except:
                    pass
        QgsApplication.messageLog().logMessage(returnunicode(bar_msg), 'Midvatten', level=log_level)
        if log_msg is not None:
            QgsApplication.messageLog().logMessage(returnunicode(log_msg), 'Midvatten', level=log_level)

    @staticmethod
    def info(bar_msg=None, log_msg=None, duration=10, button=True, optional_bar=False):
        MessagebarAndLog.log(bar_msg, log_msg, duration, Qgis.Info, Qgis.Info, button)

    @staticmethod
    def warning(bar_msg=None, log_msg=None, duration=10, button=True, optional_bar=False):
        MessagebarAndLog.log(bar_msg, log_msg, duration, Qgis.Warning, Qgis.Warning, button)

    @staticmethod
    def critical(bar_msg=None, log_msg=None, duration=10, button=True, optional_bar=False):
        MessagebarAndLog.log(bar_msg, log_msg, duration, Qgis.Critical, Qgis.Critical, button)

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
        conn = spatialite_connect(target_db,detect_types=sqlite3.PARSE_DECLTYPES|sqlite3.PARSE_COLNAMES)
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
        for tablename in list(layers_dict.keys()):
            self.to_sql(tablename)
        conn.commit()

        self.curs.execute(r"""DETACH DATABASE a""")
        self.curs.execute('vacuum')

        MessagebarAndLog.info("Export done! Layers from the new database will be loaded to your qgis project")

        conn.commit()
        conn.close()

    def to_sql(self, tname):
        columns_list = self.curs.execute("""PRAGMA table_info(%s)"""%tname).fetchall()
        columns_list = [col[1] for col in columns_list]

        if tname.startswith('zz_'):
            columns_list = [col for col in columns_list if col != 'pkuid']

        column_names = ', '.join(columns_list)

        try:
            sql = r"insert or ignore into %s (%s) select %s from a.%s" % (
                tname, column_names, column_names, tname)
            self.curs.execute(sql)
        except Exception as e:
            MessagebarAndLog.critical("Export warning: sql failed. See message log.", sql + "\nmsg: " + str(e))


def find_layer(layer_name):
    for name, search_layer in QgsProject.instance().mapLayers().items():
        if search_layer.name() == layer_name:
            return search_layer

def getcurrentlocale():
    current_locale = QgsProject.instance().readEntry("Midvatten", "locale")[0]
    return current_locale

def pop_up_info(msg='',title='Information',parent=None):#in use
    """Display an info message via Qt box"""
    QMessageBox.information(parent, title, '%s' % (msg))

def returnunicode(anything, keep_containers=False): #takes an input and tries to return it as unicode
    r"""

    >>> returnunicode('b')
    'b'
    >>> returnunicode(int(1))
    '1'
    >>> returnunicode(None)
    ''
    >>> returnunicode([])
    '[]'
    >>> returnunicode(['a', 'b'])
    "['a', 'b']"
    >>> returnunicode(['a', 'b'])
    "['a', 'b']"
    >>> returnunicode(['ä', 'ö'])
    "['\\xe4', '\\xf6']"
    >>> returnunicode(float(1))
    '1.0'
    >>> returnunicode(None)
    ''
    >>> returnunicode([(1, ), {2: 'a'}], True)
    [('1',), {'2': 'a'}]

    :param anything: just about anything
    :return: hopefully a unicode converted anything
    """
    if isinstance(anything, str):
        return anything
    elif anything is None:
        decoded = ''
    elif isinstance(anything, (list, tuple, dict, OrderedDict)):
        if isinstance(anything, list):
            decoded = [returnunicode(x, keep_containers) for x in anything]
        elif isinstance(anything, tuple):
            decoded = tuple([returnunicode(x, keep_containers) for x in anything])
        elif isinstance(anything, dict):
            decoded = dict([(returnunicode(k, keep_containers), returnunicode(v, keep_containers)) for k, v in anything.items()])
        elif isinstance(anything, OrderedDict):
            decoded = OrderedDict([(returnunicode(k, keep_containers), returnunicode(v, keep_containers)) for k, v in anything.items()])
        if not keep_containers:
            decoded = str(decoded)
    # This is not optimal, but needed for tests where nosetests stand alone PyQt4 instead of QGis PyQt4.
    elif str(type(anything)) in ("<class 'PyQt4.QtCore.QVariant'>", "<class 'PyQt5.QtCore.QVariant'>"):
        if anything.isNull():
            decoded = ''
        else:
            decoded = returnunicode(anything.toString())
    # This is not optimal, but needed for tests where nosetests stand alone PyQt4 instead of QGis PyQt4.
    elif str(type(anything)) in ("<class 'PyQt4.QtCore.QString'>", "<class 'PyQt5.QtCore.QString'>"):
        decoded = returnunicode(str(anything.toUtf8(), 'utf-8'))
    # This is not optimal, but needed for tests where nosetests stand alone PyQt4 instead of QGis PyQt4.
    elif str(type(anything)) in ("<class 'PyQt4.QtCore.QPyNullVariant'>", "<class 'PyQt5.QtCore.QPyNullVariant'>"):
        decoded = ''
    else:
        decoded = str(anything)

    if isinstance(decoded, bytes):
        for charset in ['ascii', 'utf-8', 'utf-16', 'cp1252', 'iso-8859-1', 'ascii']:
            try:
                decoded = anything.decode(charset)
            except UnicodeEncodeError:
                continue
            except UnicodeDecodeError:
                continue
            else:
                break
        else:
            decoded = str(QCoreApplication.translate('returnunicode', 'data type unknown, check database'))

    return decoded

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
            conn = spatialite_connect(dbpath,detect_types=sqlite3.PARSE_DECLTYPES|sqlite3.PARSE_COLNAMES)#dbpath is unicode already #MacOSC fix1
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
    conn = spatialite_connect(dbpath,detect_types=sqlite3.PARSE_DECLTYPES|sqlite3.PARSE_COLNAMES)
    curs = conn.cursor()
    sql2 = sql 
    curs.execute("PRAGMA foreign_keys = ON")    #Foreign key constraints are disabled by default (for backwards compatibility), so must be enabled separately for each database connection separately.

    if isinstance(sql2, str):
        try:
            resultfromsql = curs.execute(sql2) #Send SQL-syntax to cursor
        except sqlite3.IntegrityError as e:
            raise sqlite3.IntegrityError("The sql failed:\n" + sql2 + "\nmsg:\n" + str(e))
    else:
        try:
            resultfromsql = curs.executemany(sql2[0], sql2[1])
        except sqlite3.IntegrityError as e:
            raise sqlite3.IntegrityError(str(e))

    result = resultfromsql.fetchall()
    conn.commit()   # This one is absolutely needed when altering a db, python will not really write into db until given the commit command
    resultfromsql.close()
    conn.close()

    return result

def get_date_time():
    """returns date and time as a string in a pre-formatted format"""
    return datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

def write_qgs_log_to_file(message, tag, level):
    logfile = QgsLogger.logFile()
    if logfile is not None:
        QgsLogger.logMessageToFile('{}: {}({}): {} '.format('%s'%(returnunicode(get_date_time())), returnunicode(tag), returnunicode(level), '%s'%(returnunicode(message))))
