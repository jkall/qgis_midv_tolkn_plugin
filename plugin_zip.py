#!/usr/bin/env python
# coding=utf-8
"""
This scripts zips the plugin into a compressed folder suitable for  uploading to a plugin repository
The script is modified by JK and based on a  script that uploads a plugin package on the server.
        Authors: A. Pasotti, V. Picavet
        git sha              : $TemplateVCSFormat

USAGE:
cd ~/pythoncode/qgis_plugins/midv_tolkn
python plugin_zip.py
"""

import getpass
import os
import xmlrpc.client
import zipfile
from optparse import OptionParser

# Configuration
PROTOCOL = 'http'
#SERVER = 'plugins.qgis.org'
PORT = '80'
ENDPOINT = '/plugins/RPC2/'
VERBOSE = False


def main(parameters, arguments):
    """Main entry point.

    :param parameters: Command line parameters.
    :param arguments: Command line arguments.
    """

    address = "%s://%s:%s@%s:%s%s" % (
        PROTOCOL,
        parameters.username,
        parameters.password,
        parameters.server,
        parameters.port,
        ENDPOINT)
    print("Connecting to: %s" % hide_password(address))

    server = xmlrpc.client.ServerProxy(address, verbose=VERBOSE)

    try:
        plugin_id, version_id = server.plugin.upload(
            xmlrpc.client.Binary(open(arguments[0]).read()))
        print("Plugin ID: %s" % plugin_id)
        print("Version ID: %s" % version_id)
    except xmlrpc.client.ProtocolError as err:
        print("A protocol error occurred")
        print("URL: %s" % hide_password(err.url, 0))
        print("HTTP/HTTPS headers: %s" % err.headers)
        print("Error code: %d" % err.errcode)
        print("Error message: %s" % err.errmsg)
    except xmlrpc.client.Fault as err:
        print("A fault occurred")
        print("Fault code: %d" % err.faultCode)
        print("Fault string: %s" % err.faultString)


def hide_password(url, start=6):
    """Returns the http url with password part replaced with '*'.

    :param url: URL to upload the plugin to.
    :type url: str

    :param start: Position of start of password.
    :type start: int
    """
    start_position = url.find(':', start) + 1
    end_position = url.find('@')
    return "%s%s%s" % (
        url[:start_position],
        '*' * (end_position - start_position),
        url[end_position:])

def create_zipfile():#excludes are given in code below!
    file_path = os.path.realpath(__file__)
    dir_path = os.path.dirname(file_path)
    current_dir = dir_path.split(os.sep)[-1]
    zf = zipfile.ZipFile(os.path.join(dir_path, current_dir + '.zip'), mode='w')
    for root, dirs, files in os.walk(dir_path):
        dirs[:] = [d for d in dirs if d not in ['.git', 'arkiv_o_dok','__pycache__']]
        files[:] = [f for f in files if f not in ['.gitignore', 'plugin_zip.py','compile_and_prepare_for_upload_notes.txt']]#exclude specific files
        files[:]= [ file for file in files if not file.endswith( ('.pyc','.zip') ) ]#exclude specific file extensions
        for file in files:
            print(('now adding this file ' + os.path.join(root,file)))
            #print('in archive it is saved as ' + os.path.join(current_dir,file))
            print(('in archive it is saved as {}'.format(os.path.relpath(os.path.join(root, file), os.path.join(dir_path, '..')))))
            #zf.write(os.path.join(root,file),os.path.join(current_dir,file), compress_type=zipfile.ZIP_DEFLATED)
            zf.write(os.path.join(root,file),os.path.relpath(os.path.join(root, file), os.path.join(dir_path, '..')), compress_type=zipfile.ZIP_DEFLATED)
                
    zf.close()
    return os.path.join(dir_path, current_dir + '.zip')

if __name__ == "__main__":
    parser = OptionParser(usage="%prog [options] plugin.zip")
    parser.add_option(
        "-w", "--password", dest="password",
        help="Password for plugin site", metavar="******")
    parser.add_option(
        "-u", "--username", dest="username",
        help="Username of plugin site", metavar="user")
    parser.add_option(
        "-p", "--port", dest="port",
        help="Server port to connect to", metavar="80")
    parser.add_option(
        "-s", "--server", dest="server",
        help="Specify server name", default=False, metavar="plugins.qgis.org")
    options, args = parser.parse_args()
    if len(args) != 1:
        print("No zip file specified, will create one instead.\n")
        zipfilename = create_zipfile()
        args = [zipfilename]
        print(('created file: ' + args[0]))
        parser.print_help()
        #sys.exit(1)
    #if not options.server:
    #    options.server = SERVER
    if options.server: # Only upload if there actually is a server specified
        if not options.port:
            options.port = PORT
        if not options.username:
            # interactive mode
            username = getpass.getuser()
            print("Please enter user name [%s] :" % username, end=' ')
            res = input()
            if res != "":
                options.username = res
            else:
                options.username = username
        if not options.password:
            # interactive mode
            options.password = getpass.getpass()
        main(options, args)
