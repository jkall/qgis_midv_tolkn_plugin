# -*- coding: utf-8 -*-
"""
/***************************************************************************
 This is the part of the midv_tolkn plugin that (removes) and loads default qgis layers for the selected tolkn-db. 
                              -------------------
        begin                : 2016-07-30
        copyright            : (C) 2016 by Josef Källgården
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

from PyQt4.QtCore import *  
from PyQt4.QtGui import *  
from qgis.core import *  
from qgis.gui import *

import qgis.utils
import os
import locale
import collections
import midv_tolkn_utils as utils
import midv_tolkn_defs as defs

def default_layers(): # dictionary of layers with (some) corresponding data domains
    return defs.default_layers()

def relations(): #CURRENTLY NOT IN USE tuple of relation_names and relation_ids
    return defs.relations()

class LoadLayers():        
    def __init__(self, iface,db,group_name='Midvatten_TolkningsDB'):
        self.dbpath = db
        self.group_name = group_name
        self.iface = iface
        QApplication.setOverrideCursor(Qt.WaitCursor)
        if db:
            use_current_db = utils.askuser("YesNo","""Do you want to load layers from %s?"""%str(db),'Which database?')
            if use_current_db.result == 0:
                db = None
            elif use_current_db.result == '':
                return
        if not db:
            self.dbpath = QFileDialog.getOpenFileName(None, 'Ladda tolknings-db','',"Spatialite (*.sqlite)")
        if not self.dbpath:
            QApplication.restoreOverrideCursor()
            return None
        else:
            self.root = QgsProject.instance().layerTreeRoot()
            self.legend = self.iface.legendInterface()
            #self.remove_relations()
            self.remove_layers()
            self.add_layers()
            #if self.group_name == 'Midvatten_TolkningsDB':
            #    self.create_relations()
            QApplication.restoreOverrideCursor()
            
    def add_layers(self):
        obs_db_existing = self.root.findGroup('Midvatten_OBS_DB')
        if obs_db_existing:
            position_index = 1
        else:
            position_index = 0
        MyGroup = self.root.insertGroup(position_index, self.group_name)
        MySubGroup = MyGroup.addGroup(u'värdeförråd')
        uri = QgsDataSourceURI()
        uri.setDatabase(self.dbpath)
        canvas = self.iface.mapCanvas()
        layer_list = []
        layer_name_list = [] 
        layer_dict = dict() # name as key and layer as value

        # first add all data domains (beginning with zz_ in the database)
        conn_ok, dd_tables = utils.sql_load_fr_db("select name from sqlite_master where name like 'zz_%'", self.dbpath)
        if not conn_ok:
            return
        d_domain_tables = [str(dd_table[0]) for dd_table in dd_tables]
        for tablename in d_domain_tables:
            uristring= 'dbname="' + self.dbpath + '" table="' + tablename + '"'
            layer = QgsVectorLayer(uristring,tablename, 'spatialite')
            layer_list.append(layer)
            layer_name_list.append(layer.name())

        #then load all spatial layers
        layers = default_layers()  # ordered dict with layer-name:zz_layer-name
        for tablename in layers.keys():
            try:
                uri.setDataSource('',tablename,'geometry')
                layer = QgsVectorLayer(uri.uri(), tablename, 'spatialite') # Adding the layer as 'spatialite' instead of ogr vector layer is preferred
                if layer.isValid():
                    layer_list.append(layer)
                    layer_name_list.append(layer.name())
                else:
                    qgis.utils.iface.messageBar().pushMessage("Warning","Table %s not found in db. DB probably created w old plugin version."%str(tablename), 1,duration=5)
            except:
                qgis.utils.iface.messageBar().pushMessage("Warning","Table %s not found in db. DB probably created w old plugin version."%str(tablename), 1,duration=5)
        #now loop over all the layers and set styles etc
        for layer in layer_list:
            QgsMapLayerRegistry.instance().addMapLayers([layer],False)
            if layer.name() in d_domain_tables:
                MySubGroup.insertLayer(0,layer)
            else:
                MyGroup.insertLayer(0,layer)
            layer_dict[layer.name()] = layer

            #now try to load the style file
            stylefile = os.path.join(os.sep,os.path.dirname(__file__),"sql_strings",layer.name() + ".qml")
            try:
                layer.loadNamedStyle(stylefile)
            except:
                pass
            if layer.name() == 'gvmag':#zoom to gvmag extent
                canvas.setExtent(layer.extent())
            else:
                pass

        MySubGroup.setExpanded(False)

        # fix value relations
        for lyr in layers.keys():
            if lyr in layer_name_list:
                if not layers[lyr]==None:
                    self.create_layer_value_relations(layer_dict[lyr], layer_dict[layers[lyr]], layer_dict[lyr].dataProvider().fieldNameIndex('typ'), 'typ','beskrivning')

        #special for gvflode
        self.create_layer_value_relations(layer_dict['gvflode'], layer_dict['zz_gvmag'], layer_dict['gvflode'].dataProvider().fieldNameIndex('intermag'), 'typ','beskrivning')

        #finally refresh canvas
        canvas.refresh()

    def create_relations(self):#CURRENTLY NOT IN USE (NOT WORKING AS EXPECTED, ONLY RANDOMLY CREATING BOTH RELATIONS!!!  ALSO, SOMETIMES QGIS CRASH WHEN OPENING FORMS)
        """
        1. create project relations obs_points-comments and obs_points-stratigraphy
        2. add 2 tabs to the obs_points form and fill those tabs with related layers comments and stratigraphy
        """
        # create relations
        i=0
        layers = default_layers()
        rel_tuples = relations()
        for lyr in layers.keys():
            rel = QgsRelation()
            rel.setReferencingLayer( utils.find_layer(layers[lyr]).id() )
            rel.setReferencedLayer( utils.find_layer(lyr).id() )
            rel.addFieldPair( 'typ', 'typ' )
            rel.setRelationId(rel_tuples[i][1])
            rel.setRelationName(rel_tuples[i][0])
            if rel.isValid(): # It will only be added if it is valid. If not, check the ids and field names                
                QgsProject.instance().relationManager().addRelation(rel)
                #validate
                for key in QgsProject.instance().relationManager().relations().iterkeys():
                    #print(key)
                    if str(key)==rel.id():
                        print('added relation %s'%str(lyr))
            else:
                qgis.utils.iface.messageBar().pushMessage("Error","""Failed to create relation %s!"""%str(lyr),2)
                print("""Failed to create relation %s!"""%str(lyr))
            i+=1

        """
        #now add attribute editor tabs with theses relations
        layer = utils.find_layer('obs_points')
        # skapa en container
        if  utils.getcurrentlocale() == 'sv_SE':
            tab1name = 'kommentarer'
            tab2name = u'lagerföljder'
        else:
            tab1name = 'comments'
            tab2name = 'stratigraphy'
        x = QgsAttributeEditorContainer (tab1name,layer)
        # ange att containern är av tab-typ (True=group box, False=Tab)
        x.setIsGroupBox (False)
        # lägg till den till lagret
        layer.addAttributeEditorWidget(x)
        # skapar först en en attribute-editor-relation
        p= QgsAttributeEditorRelation('obs_points_comments_id',rel1,x)
        # sen ska den läggas till attributecontainer
        x.addChildElement(p)
        ## sedan samma för lagerföljder
        y = QgsAttributeEditorContainer (tab2name,layer)
        y.setIsGroupBox (False)
        layer.addAttributeEditorWidget(y)
        q= QgsAttributeEditorRelation('stratigraphy_id',rel2,y)
        y.addChildElement(q)
        """

    def create_layer_value_relations(self, the_layer, target_layer, index,key_field, value_field):#these are layer-specific value maps, not project relations
        the_layer.editFormConfig().setWidgetType(index,"ValueRelation")

        cfg = dict()
        cfg['Layer'] = target_layer.id()
        cfg['Key'] = key_field
        cfg['Value'] = value_field
        cfg['AllowNull'] = True
        cfg['OrderByValue'] = False
        cfg['UseCompleter']= False
        cfg['AllowMulti']= False
        # Add more if you like
        the_layer.editFormConfig().setWidgetConfig(index, cfg)

        #u'UseCompleter': False, u'AllowMulti': False, u'AllowNull': True, u'OrderByValue': True, u'Value': u'beskrivning', u'Key': u'typ'

    def remove_layers(self): 
        try:
            remove_group = self.root.findGroup(self.group_name)
            self.root.removeChildNode(remove_group)
            qgis.utils.iface.messageBar().pushMessage("Information","""Removed any old group 'Midvatten_TolkningsDB with associated layers""",1,duration=10)
        except:
            print('could not remove layers, probably not existing')
            
    def remove_relations(self):#currently not in use
        # remove relations
        for key in QgsProject.instance().relationManager().relations().iterkeys():
            if key in relations()[1]:
                del QgsProject.instance().relationManager().relations()[key]
                print('removed relation %s'%str(key))
