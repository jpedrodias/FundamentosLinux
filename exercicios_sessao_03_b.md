# Exercícios de permissões de arquivos e pastas



## Questão 1.
Considere a seguinte saída do comando id:
```bash
$ id emma 
uid=1000(emma) gid=1000(emma) 
groups=1000(emma),4(adm),5(tty),10(uucp),20(dialout),27(sudo),46(plugdev)
```


Em quais arquivos estão armazenados os atributos a seguir?
* **UID** e **GID**
* Grupos
* Adicionalmente, em qual arquivo a senha do utilizador é armazenada? 

> Resposta:
* UID e GID pode ser consultado em `/etc/passwd`
* Grupos em `/etc/group`
* hash das senhas em `/etc/shadow`



## Questão 2.
Como é possível obter uma lista dos logins ativos de seu sistema e uma contagem deles?

> Resposta:
Para obter a listagem dos logins ativos pode usar-se:
```bash
$ who
```
E para obter a contagem dos users ativos:
```bash
$ who | wc -l
```



## Questão 3.
Usando o comando grep, temos o resultado abaixo com informações sobre o  utilizador emma.

```bash
$ grep emma /etc/passwd
emma:x:1000:1000:Emma Smith,42 Douglas St,555.555.5555,:/home/emma:/bin/ksh
```

Preencha as informações apropriadas usando a saída do comando anterior.

> Resposta:

```text
Nome de utilizador: emma
Senha:              x - ou seja, o hash da senha está no ficheiro /etc/shadow
GID principal:      1000
GECOS:              Emma Smith,42 Douglas St,555.555.5555
Diretório inicial:  /home/emma
Shell:              /bin/ksh
```



## Questão 4. 
Indique a que arquivo se refere cada uma das entradas a seguir: 

> Resposta:


* developer:x:1010:frank,grace,dave => **/etc/group**
* root:x:0:0:root:/root:/bin/bash   => **/etc/passwd**
* henry:$1$.AbCdEfGh123456789A1b2C3d4.:18015:20:90:5:30:: => **/etc/shadow**
* henry:x:1000:1000:User Henry:/home/henry:/bin/bash => **/etc/passwd**
* staff:!:dave:carol,emma => **/etc/gshadow**


## Questão 5. 
Observe esta saída para responder às sete questões a seguir: 
```bash
# cat /etc/passwd | tail -3 
dave:x:1050:1050:User Dave:/home/dave:/bin/bash 
carol:x:1051:1015:User Carol:/home/carol:/bin/sh 
henry:x:1052:1005:User Henry:/home/henry:/bin/tcsh 
# cat /etc/group | tail -3 
web_admin:x:1005:frank,emma 
web_developer:x:1010:grace,kevin,christian 
dave:x:1050: 
# cat /etc/shadow | tail -3 
dave:$6$AbCdEfGh123456789A1b2C3D4e5F6G7h8i9:0:20:90:7:30:: 
carol:$6$q1w2e3r4t5y6u7i8AbcDeFgHiLmNoPqRsTu:18015:0:60:7::: 
henry:!$6$123456789aBcDeFgHa1B2c3d4E5f6g7H8I9:18015:0:20:5::: 
# cat /etc/gshadow | tail -3 
web_admin:!:frank:frank,emma 
web_developer:!:kevin:grace,kevin,christian 
dave:!::
```

* Qual o identificador de utilizador (UID) e identificador de grupo (GID) de carol? 
  > Resposta: **1051**

* Qual shell está configurado para dave e henry?
  > Resposta: **/bin/tcsh**

* Qual o nome do grupo principal de henry?
  > Resposta: group 1005, ou seja, **web_admin**

* Quem são os membros do grupo web_developer? 
  > Resposta: **grace,kevin,christian**

* Qual utilizador não pode fazer login no sistema?
  > Resposta: **henry** porque o hash da senha começa com `!`

* Qual utilizador deverá mudar a senha na próxima vez em que fizer login no sistema?
  > Resposta: **dave**

* Quantos dias devem se passar até que seja exigida uma alteração de senha  para carol?
  > Resposta: **60**



## 6. Crie um diretório chamado emptydir usando o comando mkdir emptydir. Em seguida, usando ls, liste as permissões do diretório emptydir.

> Resposta:
```bash
$ mkdir emptydir
$ ls -ld emptydir
drwxrwxr-x 2 pedrodias pedrodias 4096 Aug 20 10:49 emptydir
```



## Questão 7.
Crie um arquivo vazio chamado emptyfile com o comando touch emptyfile. 
Em seguida, usando chmod com notação simbólica, adicione permissões de execução ao proprietário do arquivo emptyfile e remova as permissões de gravação e execução para todos os outros. Faça isso usando apenas um comando chmod.

> Resposta:
```bash
$ touch emptyfile

# Em apenas um comando chmod
$ chmod u+x,go-wx emptyfile
```



## Questão 8. 
Quais serão as permissões de um arquivo chamado text.txt depois de executar o comando chmod 754 text.txt?

> Resposta: 
> * 7 (user)   => `7 = b111` ou seja, pode ler, escrever e executar
> * 5 (grupo)  => `5 = b101` pode ler, não pode escrever e pode executar
> * 4 (outros) => `4 = b100` pode ler, não pode escrever nem executar



# end of file