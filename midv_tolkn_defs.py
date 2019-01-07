# -*- coding: utf-8 -*-
"""
/***************************************************************************
 This is the "definitions" part of the midv_tolkn plugin
                              -------------------
        begin                : 2016-11-09
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

import collections

def default_layers(): # dictionary of layers with (some) corresponding data domains and relevant layer names
    d = collections.OrderedDict()
    d['sprickzon']=(None,'sprickzoner m.m.')
    d['strukturlinje']=('zz_strukturlinje','strukturlinjer m.m.')
    d['gvmag']=('zz_gvmag','grundvattenmagasin')
    d['gvflode']=('zz_gvflode','grundvattenflöde')
    d['gvdel']=('zz_gvdel','grundvattendelare och andra gränser')
    d['tillromr']=('zz_tillromr','tillrinningsområden')
    d['trptid']=('zz_trptid','transporttid')
    d['omattad_zon']=('zz_omattad_zon','omättad zon')
    return d

def relations(): #CURRENTLY NOT IN USE tuple of relation_names and relation_ids
    return (('gvmag_relation','gvmag_relation_id'),('gvdel_relation','gvdel_relation_id'),('gvflode_relation','gvflode_relation_id'),('tillromr_relation','tillromr_relation_id'),('strukturlinje_relation','strukturlinje_relation_id'),('trptid_relation','trptid_relation_id'))

 
