> **⚠️ Este ficheiro está em construção. O conteúdo pode ser alterado ou incompleto.**
# Configurar a Interface


## Consulta inicial
Consultar a redes atuais
```bash
ip a
```

```bash
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:44:09:51 brd ff:ff:ff:ff:ff:ff
    inet 192.168.2.126/24 metric 100 brd 192.168.2.255 scope global dynamic enp0s3
       valid_lft 2607sec preferred_lft 2607sec
    inet6 fe80::a00:27ff:fe44:951/64 scope link 
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 08:00:27:2b:50:ab brd ff:ff:ff:ff:ff:ff
```

## Nova configuração
Editar o ficheiro para adicionar as conf da rede `enp0s8`

/etc/netplan/50-cloud-init.yaml

```bash
cd /etc/netplan
ls
sudo nano 50-cloud-init.yaml
```


E colocar estas instruções
```yml
network:
  version: 2
  ethernets:
    enp0s3:
      dhcp4: true
    enp0s8:
      dhcp4: false
      addresses: [192.168.5.1/24]
      routes:
        - to: default
          via: 192.168.5.254
      nameservers:
        addresses: [192.168.5.1, 1.1.1.1, 8.8.8.8]
```

## Aplicar novas configurações
E aplicar as novas definições
```bash
sudo netplan applay
```

## Consultar resultado
```bash
ip a
```

```text
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:2b:50:ab brd ff:ff:ff:ff:ff:ff
    inet 192.168.5.1/24 brd 192.168.5.255 scope global enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe2b:50ab/64 scope link 
       valid_lft forever preferred_lft forever
```

****

# Adicionar um servidor de DHCP

## Instalação
```bash
sudo ip link enp0s8 down
sudo ip link enp0s8 up
sudo apt install isc-dhcp-server
```


***

## Configuração
```bash
sudo nano /etc/default/isc-dhcp-server
```

```text
INTERFACESv4="enp0s8"
INTERFACESv6=""
```

```bash
sudo nano /etc/dhcp/dhcpd.conf
```

```text
subnet 192.168.5.0 netmask 255.255.255.0 {
  range 192.168.5.100 192.168.5.199;
  option subnet-mask 255.255.255.0;
  option routers 192.168.5.254;
  option broadcast-address 192.168.5.255;
  default-lease-time 600;
  max-lease-time 7200;    
}
```

```bash
sudo systemctl restart isc-dhcp-server
sudo systemctl status isc-dhcp-server
```

# Outros comandos:

```bash
cat /var/lib/dhcp/dhcpd.leases
```


Vê as rotas: ip route
Testa DNS: 
resolvectl status
dig A example.com


*** 

# Noutra máquina


# Serviço DNS

```bash
sudo apt install bind9 bind9utils bind9-doc
```

```bash
sudo cp /etc/bind/db.empty /etc/bind/forward.lablinux.pt
sudo nano /etc/bind/forward.lablinux.pt
```

```text
; BIND reverse data file for lablinux rfc1918 zone
;
$TTL    86400
@       IN      SOA     ubuntu-server.lablinux.pt. admin.lablinux.pt. (
                     2025082001         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                          86400 )       ; Negative Cache TTL
;
@       IN      NS      ubuntu-server.lablinux.pt.
@       IN      A       192.168.5.1
ubuntu-server IN A      192.168.5.1
www     IN       A      192.168.5.1
```




```bash
sudo cp /etc/bind/db.empty /etc/bind/reverse.lablinux.pt
sudo nano /etc/bind/reverse.lablinux.pt
```


```text
; BIND reverse data file for lablinux rfc1918 zone
;
$TTL    86400
@       IN      SOA     ubuntu-server.lablinux.pt. admin.lablinux.pt. (
                     2025082001         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                          86400 )       ; Negative Cache TTL
;
@       IN      NS      ubuntu-server.lablinux.pt.
1       IN      PTR     ubuntu-server.lablinux.pt.
```


```bash
sudo nano /etc/bind/named.conf.local
```


```text
zone "lablinux.pt" IN { 
    type master;
    file "/etc/bind/forward.lablinux.pt";
};

zone "5.168.192.in-addr.arpa" IN {
  type master;
  file "/etc/bind/reverse.lablinux.pt";
};
```


```bash
sudo systemctl restart bind9

journalctl -xeu named.service
```


dig -x 127.0.0.1
dig google.pt

```bash
sudo named-checkzone lablinux.pt /etc/bind/forward.lablinux.pt
sudo named-checkzone 5.168.192.in-addr.arpa /etc/bind/reverse.lablinux.pt
```



# ainda

```bash
sudo nano /etc/dhcp/dhcpd.conf
```


adicionar 
```text
  option domain-name-servers ubuntu-server.lablinux.pt;
  option domain-name "lablinux.pt";


sudo systemctl restart isc-dhcp-server
sudo systemctl status isc-dhcp-server
```


# ficheiro dos encaminhadores

```bash
sudo nano /etc/bind/named.conf.options 
```

```text
options {
    listen-on { 127.0.0.1; 192.168.5.1; }; 
    //Permissões de consulta 
    allow-query { localhost; 192.168.5.0/24; }; 
    //Configurações de DNS recursivo 
    recursion yes; 
    forwarders { 
      8.8.8.8; 
      8.8.4.4; 
    }; 
    listen-on-v6 { none; }; 
};
```


***
verificar qual o DNS que está configurado
```bash
sudo apt  install network-manager

nmcli dev show | grep DNS
```


```bash
# desliga 
# enp0s3 - a placa de rede original
# enp0s8 - a placa adicionada para o serviço
sudo ip link set enp0s3 down

sudo ip link set enpps3 down
```



---
Trocar a route default
```bash
sudo ip route del default
sudo ip route add default via 192.168.2.1 dev enp0s3
ip route show
```

```bash
sudo ip route del default
sudo ip route add default via 192.168.5.254 dev enp0s8
te show
```


---
no cliente
```
cat /etc/resolv.conf
``