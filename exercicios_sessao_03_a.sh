#!/bin/bash


pausa() {
    echo -e "\033[31m[q] para sair\033[0m ou Enter para continuar..."
    read -r option
    if [ "$option" == "q" ]; then
        exit 0
    fi
}

limpeza(){
	# limpeza inicial para poder repetir
	_USERS="joao carlos marta vanessa daniel pedro aluno1 aluno2 prof user1 esintlogin"
	_GROUPS="lab1 lab2 lab3 alunos todos utilizadores esintlogin"
	_FILES="user_ordenado.txt group_ordenado.txt"
	echo "A remover utilizadores..."
	for u in $_USERS; do
		echo "A remover utilizador: $u"
		sudo userdel -r "$u"
	done

	echo "A remover grupos..."
	for g in $_GROUPS; do
		echo "A remover grupo: $g"
		sudo groupdel -f "$g"
	done

	echo "A remover ficheiros..."
	for f in $_FILES; do
	[ -e "$f" ] && rm -- "$f"
	done

}

echo "Começamos com uma limpeza inicial que remove os utilizadores todos"
pausa
limpeza
echo "Limpeza feita."
pausa




echo "Exercício 1:"
echo "- Criar os grupos com groupadd?"
echo "  (lab1 lab2 lab3 alunos todos)"
pausa
sudo groupadd lab1
sudo groupadd lab2
sudo groupadd lab3
sudo groupadd alunos
sudo groupadd todos
echo "feito"
pausa




echo "- Criar os utilizadores com useradd?"
echo "  (joao carlos marta vanessa daniel pedro aluno1 aluno2 prof)"
pausa

sudo useradd -m -s /bin/bash -g lab1 -G todos joao
sudo useradd -m -s /bin/bash -g lab1 -G todos carlos

sudo useradd -m -s /bin/bash -g lab2 -G todos marta
sudo useradd -m -s /bin/bash -g lab2 -G todos vanessa

sudo useradd -m -s /bin/bash -g lab3 -G todos daniel
sudo useradd -m -s /bin/bash -g lab3 -G todos pedro

sudo useradd -m -s /bin/bash -g alunos aluno1
sudo useradd -m -s /bin/bash -g alunos aluno2
sudo useradd -m -s /bin/bash -g todos prof
echo "feito"
pausa




echo "- Criar as passwords para os utilizadores?"
pausa

echo "joao:12345"    | sudo tee /etc/chpasswd | sudo chpasswd
echo "carlos:12345"  | sudo tee /etc/chpasswd | sudo chpasswd
echo "marta:12345"   | sudo tee /etc/chpasswd | sudo chpasswd
echo "vanessa:12345" | sudo tee /etc/chpasswd | sudo chpasswd
echo "daniel:12345"  | sudo tee /etc/chpasswd | sudo chpasswd
echo "pedro:12345"   | sudo tee /etc/chpasswd | sudo chpasswd
echo "aluno1:12345"  | sudo tee /etc/chpasswd | sudo chpasswd
echo "aluno2:12345"  | sudo tee /etc/chpasswd | sudo chpasswd
echo "prof:12345"    | sudo tee /etc/chpasswd | sudo chpasswd
echo "feito"
pausa




echo "Exercício 2:"
echo "- Exibir o arquivo que contém os utilizadores do sistema?"
echo "  (IGNORANDO users de sistema)"
ls -lh /etc/passwd
pausa
#cat /etc/passwd | grep /home/ | cut -f1 -d:
getent passwd | awk -F: '$3>=1001 && $3<65000' | cut -f1 -d:
pausa




echo "Exercício 3:"
echo "- Exibir o arquivo que contém os grupos do sistema?"
ls -lh /etc/group
pausa
#awk -F: '$3>=1001 && $3<65000' /etc/group | cut -f1 -d:
getent group | awk -F: '$3>=1001 && $3<65000' | cut -f1 -d:
pausa




echo "Exercício 4:"
echo "- Exibir o arquivo que contém as passwords criptografadas dos utilizadores do sistema?"
ls -lh /etc/shadow
pausa
sudo cat /etc/shadow
pausa




echo "Exercício 5:"
echo "- Exibir o arquivo que contém as passwords criptografadas dos grupos do sistema?"
ls -lh /etc/gshadow
pausa
sudo cat /etc/gshadow
pausa




echo "Exercício 6:"
echo "- Mudar o nome de login do utilizador aluno1 para user1?"
echo "  (alterando também a home)"
pausa
echo "Antes"
cat /etc/passwd | grep aluno1
sudo usermod -l user1 -d /home/user1 -m aluno1
echo "Depois"
cat /etc/passwd | grep user1
pausa




echo "Exercício 7:"
echo "- Mudar o nome do grupo alunos para utilizadores?"
pausa
echo "Antes"
cat /etc/group | grep alunos
sudo groupmod -n utilizadores alunos
echo "Depois"
cat /etc/group | grep utilizadores
pausa




echo "Exercício 8:"
echo "- Atribuir uma password para o grupo utilizadores?"
sudo cat /etc/gshadow | grep utilizadores
pausa

SENHA=$(openssl passwd -6 "12345")
ESC_SENHA="${SENHA//&/\\&}"   # escapa '&' para o sed

echo "Senha 12345 ficará guardada como $ESC_SENHA"
sudo sed -i "s|^\(utilizadores:\)[^:]*:|\1${ESC_SENHA}:|" /etc/gshadow
sudo cat /etc/gshadow | grep utilizadores
pausa




echo "Exercício 9:"
echo "- Inclua no grupo utilizadores, os utilizadores joão e marta?"
pausa
sudo gpasswd -a joao utilizadores
sudo gpasswd -a marta utilizadores
pausa




echo "Exercício 10:"
echo "- Retire do grupo utilizadores, os utilizadores joão e marta?"
pausa
sudo gpasswd -d joao utilizadores
sudo gpasswd -d marta utilizadores
pausa




echo "Exercício 11:"
echo "- Apague o grupo utilizadores?"
pausa
sudo groupdel utilizadores
pausa




echo "Exercício 12:"
echo "- Quantos utilizadores tem no servidor?"
echo "  (devem estar os 9 do exercício mais o próprio)"
sudo cat /etc/passwd | awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' | wc -l
pausa




echo "Exercício 13:"
echo "- Grave no arquivo user_ordenado.txt o login de todos utilizadores do servidor ordenado por nome e numerado."
echo "  (IGNORAR os users de sistema)"
pausa
sudo getent passwd | awk -F: '$3>=1001 && $3<65000' | cut -f1 -d: | sort | nl > user_ordenado.txt
ls -lh ./user_ordenado.txt
cat ./user_ordenado.txt
pausa




echo "Exercício 14:"
echo "- Grave no arquivo group_ordenado.txt a relação de todos os grupos do servidor ordenado por nome e numerado."
echo "  (IGNORAR os groups de sistema)"
pausa
sudo getent group | awk -F: '$3>=1001 && $3<65000' | cut -f1 -d: | sort | nl > group_ordenado.txt
ls -lh ./group_ordenado.txt
cat ./group_ordenado.txt
pausa




echo "Exercício 15:"
echo "- Coloque a password criptografada dentro do arquivo /etc/passwd"
pausa
echo "Antes (campo da password deve ser 'x'):"
sudo getent passwd | awk -F: '$3>=1001 && $3<65000'
pausa
sudo pwunconv
echo "Depois (campo da password fica com hash):"
sudo getent passwd | awk -F: '$3>=1001 && $3<65000'




echo "Exercício 16:"
echo "Devolva a password para o arquivo /etc/shadow"
echo "Antes"
sudo getent passwd | awk -F: '$3>=1001 && $3<65000'
pausa
sudo pwconv
echo "Depois"
sudo getent passwd | awk -F: '$3>=1001 && $3<65000'
pausa




echo "Exercício 17:"
echo "- Crie um utilizador chamado esintlogin que não se liga no sistema"
pausa
sudo useradd -r -s /usr/sbin/nologin esintlogin	
sudo getent passwd | grep esintlogin




echo "Exercício 18:"
echo "Apague os grupos lab1, lab2, lab3 e todos."
echo "  (e todos os restantes)"
pausa
limpeza


echo -e "\033[31m ╔═════════════════════╗ \033[0m"
echo -e "\033[31m ║ Exercício terminado ║ \033[0m"
echo -e "\033[31m ╚═════════════════════╝ \033[0m"