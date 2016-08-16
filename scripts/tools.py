#!/usr/bin/python3

'''
this script will install all the required packages that you need on
ubuntu to compile and work with this package.
'''

###########
# imports #
###########
import subprocess # for check_call, DEVNULL, check_output
import yaml # for load
import os.path # for isfile
import os # for system

##############
# parameters #
##############
# do you want to debug this script?
opt_debug=False
# do you want to show progress?
opt_progress=True
# what ppas do you want to add?
opt_ppas=[
]
# what keys to download and trust via apt-key?
opt_keys_download=[
]
# keys to receive from keyservers
opt_keys_receive=[
]
# packages to install
opt_packs=[
]
# update apt
opt_update=False

#############
# functions #
#############
do_msg=True
def msg(s):
    if do_msg:
        print(s)

do_debug=False
def debug(s):
    if do_debug:
        print(s)

# the lines we are interested in look like this:
# pub   4096R/EFE21092 2012-05-11
def keys_read():
    global all_keys
    all_keys=set()
    output=subprocess.check_output([
        'apt-key',
        'list',
    ]).decode().strip()
    for line in output.split('\n'):
        if not line.startswith('pub'):
            continue
        parts=line.split()
        all_keys.add(parts[1].split('/')[1])

def keys_have(key_id):
    return key_id in all_keys

def get_codename():
    codename=subprocess.check_output([
        'lsb_release',
        '--codename',
        '--short',
        ]).decode().strip()
    if opt_debug:
        print('codename is [{0}]'.format(codename))
    return codename

APT_FILE='apt.yaml'
def install_apt():
    # if the file is not there it is NOT an error
    if not os.path.isfile(APT_FILE):
        return
    msg('installing from [{0}]...'.format(APT_FILE))
    with open(APT_FILE, 'r') as stream:
        o=yaml.load(stream)
    packs=[ x['name'] for x in o['packages'] ]
    args=[
        'sudo',
        'apt-get',
        'install',
        '--assume-yes'
    ]
    args.extend(packs)
    subprocess.check_call(args, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

NODE_FILE='package.json'
def install_node():
    # if the file is not there it is NOT an error
    if not os.path.isfile(NODE_FILE):
        return
    msg('installing from [{0}]...'.format(NODE_FILE))
    subprocess.check_call([
        'npm',
        'install',
    ], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def do_start():
    keys_read()
    codename=get_codename()
    altered_apt_configuration=False

def do_ppas():
    for ppa in opt_ppas:
            if opt_progress:
                    print('processing ppa [{0}]...'.format(ppa))
            # cinelerra-ppa-ppa-trusty.list
            short_ppa=ppa[4:]
            parts=short_ppa.split('/')
            filename='/etc/apt/sources.list.d/{0}-{1}-{2}.list'.format(parts[0], parts[1], codename)
            if opt_debug:
                    print('filename is [{0}]'.format(filename))
            if os.path.isfile(filename):
                    if opt_progress:
                            print('already there in [{0}]...'.format(filename))
                    continue
            altered_apt_configuration=True
            subprocess.check_call([
                    'sudo',
                    'add-apt-repository',
                    #'--enable-source', # source code too
                    '--yes', # dont ask questions
                    ppa
            ], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def download_keys():
    for dl, key_id in opt_keys_download:
        if opt_progress:
            print('processing download key [{0}], [{1}]...'.format(dl, key_id))
        if keys_have(key_id):
            if opt_progress:
                print('already have this key')
            continue
        altered_apt_configuration=True
        if opt_progress:
            print('downloading key...')
        os.system('wget -q -O - {0} | sudo apt-key add -'.format(dl))
        keys_read()
        assert keys_have(key_id)

def receive_keys():
    for srvr, key_id in opt_keys_receive:
        if opt_progress:
            print('processing receive key [{0}], [{1}]...'.format(srvr, key_id))
        if keys_have(key_id):
            if opt_progress:
                print('already have this key')
            continue
        altered_apt_configuration=True
        if opt_progress:
            print('receiving key...')
        subprocess.check_call([
            'sudo',
            'apt-key',
            'adv',
            '--keyserver',
            srvr,
            '--recv-keys',
            key_id,
        ], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        keys_read()
        assert keys_have(key_id)

def update_apt():
    if altered_apt_configuration and opt_update:
        if opt_progress:
            print('updating apt states...')
        subprocess.check_call([
            'sudo',
            'apt-get',
            'update',
        ],
            #stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        # remove unneeded .save apt files
        os.system('sudo rm -f /etc/apt/sources.list.d/*.save /etc/apt/sources.list.save')

def install_packs():
    if opt_progress:
        print('installing packages...')
    args=[
        'sudo',
        'apt-get',
        'install',
    #    '--assume-yes',
    ]
    args.extend(opt_packs)
    try:
        subprocess.check_call(
            args,
            #stdout=subprocess.DEVNULL,
            #stderr=subprocess.DEVNULL,
        )
    except:
        print('error in apt')

########
# code #
########
install_apt()
install_node()
