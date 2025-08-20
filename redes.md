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


Vê as rotas: ip route
Testa DNS: 
resolvectl status
dig A example.com


*** 

# Noutra máquina
