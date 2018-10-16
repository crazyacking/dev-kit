#!/usr/bin/env python

"""
@author: crazyacking@gmail.com
@link: http://www.zhihan.me
"""

import json
import subprocess
import argparse


def get_ips(config_json='config.json'):
    with open(config_json, 'r') as f:
        config = json.load(f)
        ips = []
        if "manager_ips" in config.keys():
            for ip in config['manager_ips']:
                ips.append(ip)
        if "dtr_ips" in config.keys():
            for ip in config['dtr_ips']:
                ips.append(ip)
        if "install_haproxy" in config.keys() and config['install_haproxy']:
            ips.append(config['manager_vip'])
            if 'dtr_vip' in config.keys() and config['manager_vip'] != config['dtr_vip']:
                 ips.append(config['dtr_vip'])
        if 'install_nfs' in config.keys() and config['install_nfs']:
              ips.append(config['nfs_server_ip'])
        if 'install_ntp_server' in config.keys() and config['install_ntp_server']:
              ips.append(config['ntp_server_ip'])
        if 'install_k8s' in config.keys() and config['install_k8s']:
            for ip in config['k8s_configs']['manager_ips'] + config['k8s_configs']['worker_ips']:
                ips.append(ip)
            if 'node_ips' in config['k8s_configs']:
                for node_ip in config['k8s_configs']['node_ips']:
                    ips.append(node_ip)
        return ips


def tunnel(ips):

    subprocess.call(["ssh-keygen"])

    for ip in ips:
        subprocess.call(["ssh-copy-id", "-o", "StrictHostKeyChecking=false", "root@%s" % ip])


def tunnel_by_nodes(args):
    ips = args['nodes'].split(",")
    tunnel(ips)


def tunnel_by_args(args):
    ips = get_ips(args['config_json'])
    tunnel(ips)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Create SSH tunnel via Config JSON file or args.')
    parser.add_argument("-j", "--config-json", dest="config_json", default="config.json",
                        help="Config JSON file, default is config.json")
    sub_parsers = parser.add_subparsers(dest="target")
    sub_parsers.required = True

    parser_tunnel = sub_parsers.add_parser('tunnel')
    parser_tunnel.set_defaults(func=tunnel_by_args)

    parser_node = sub_parsers.add_parser('node')
    parser_node.add_argument("-n", "--nodes", dest="nodes", required=True,
                             help="nodes' ip to create SSH tunnel, eg., 192.168.0.1, 192.168.0.2")
    parser_node.set_defaults(func=tunnel_by_nodes)

    args = parser.parse_args()
    args_dict = vars(args)
    args.func(args_dict)
