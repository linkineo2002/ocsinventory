#!/bin/bash
# Autor: Robson Vaamonde
# Edicao: Fabio Silva
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 09/02/2018
# Data de atualização: 09/02/2018
# Versão: 0.1

# Procedimentos para instalação do Agente do OCS Inventory na Plataforma GNU/Linux
# Script de instalação para distribuição derivadas do Debian (Ubuntu e Linux Mint)
# Script adaptado para a instalação no UCS Univention Corporate Server

echo -e "Ativando os Repositórios não mantidos pelo UCS, aguarde..."
# Ativando os Repositórios não mantidos do UCS Univention
ucr set repository/online/unmaintained='yes'
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Verificando se source.list foi criado com sucesso, aguarde..."
# Verificando o source.list se foi criado com sucesso.
less /etc/apt/sources.list.d/15_ucs-online-version.list
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Atualizando o UCS Univention, aguarde..."
# Atualizar a distribuição
univention-upgrade
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Instalando o OCS Inventory Agent e suas Dependências, aguarde..."
# Instalando o OCSyInventory Agent e suas Dependências.
univention-install ocsinventory-agent libnet-ssleay-perl libcrypt-ssleay-perl vim git
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Baixando o arquivo do Certificado e das Configurações do OCS Inventory Agent, aguarde..."
# Fazendo o download dos arquivos do Servidor OCS Inventory
wget http://ocs.aexlog.intra/download/ocs.crt
echo
wget http://ocs.aexlog.intra/download/ocsinventory-agent.cfg
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Copiando o arquivo do Certificado, aguarde..."
# Copiando o arquivo de Certificado Raiz
cp -v ocs.crt /usr/local/share/ca-certificates/ocs.crt
echo
cp -v ocs.crt /etc/ocsinventory/ocs.crt
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Atualizando o Certificado Raiz, aguarde..."
# Atualizando o Certififcado Raiz do Desktop
update-ca-certificates
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Testando a conexão HTTPS, aguarde..."
# Testando se o Certificado está funcionando com o wget
wget https://ocs.aexlog.intra/download/ocs.crt -O /tmp/ocs.crt
echo -e "Caso aparece alguma mensagem de ERRO, verificar a opção: update-ca-certificates"
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Atualizando o arquivo de configuração do OCS Inventory Agent, aguarde..."
# Atualizando o arquivo de configuração do OCS Inventory Agent
cp -v ocsinventory-agent.cfg /etc/ocsinventory/ocsinventory-agent.cfg
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Editando o arquivo de configuração do OCS Inventory Agent, aguarde..."
# Editando o arquivo de configuração do OCS Inventory Agent
vim /etc/ocsinventory/ocsinventory-agent.cfg
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Criando o Diretório de Log do OCS Inventory Agent, aguarde..."
# Criando o Diretório de Log OCS Inventory Agent
mkdir -v /var/log/ocsinventory-agent/
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Criando o Arquivo de Log do OCS Inventory Agent, aguarde..."
# Criando o Arquivo de Log do OCS Inventory Agent
touch /var/log/ocsinventory-agent/activity.log
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Executando o inventário novamente, aguarde..."
# Atualizando o Inventário
echo > /var/log/ocsinventory-agent/activity.log
echo
ocsinventory-agent --debug -i
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Analisando o arquivo de Log do OCS Inventory Agent, aguarde..."
# Verificando o conteúdo do Arquivo de Log do OCS Inventory Agent
less /var/log/ocsinventory-agent/activity.log
echo -e "Pressione <Enter> para continuar..."
read
clear
