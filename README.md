## Домашнее задание: bash.
### Цель:
#### Написать скрипт bash  для мониторинга лога web

### Для выполнения работы используются следующие инструменты:
- VirtualBox - среда виртуализации, позволяет создавать и выполнять виртуальные машины;
- Vagrant - ПО для создания и конфигурирования виртуальной среды. В данном случае в качестве среды виртуализации используется VirtualBox;
- Ansible - Система управления конфигурациями, написанная на языке программирования Python;
- Git - система контроля версий

### Аккаунты:
- GitHub - https://github.com/

### Создание образа
#### bash - server
```
vagrant up
```
### Подготовка ssh 
```
ssh-keygen -R "[127.0.0.1]:2222" -f ~/.ssh/known_hosts
ssh -p 2222 vagrant@127.0.0.1 -i ~/.ssh/known_hosts
ansible all -m ping -i hosts.ini
```
### Настройка хоста 
```
ansible-playbook -i hosts.ini bash_1.yml
```
### Генерация http обращений 
```
ansible bash -m shell -a 'for i in {1..15} ; do wget 127.0.0.1 ; done;' -i hosts.ini -b
ansible bash -m shell -a 'for i in {1..10} ; do wget 127.0.0.1 --bind-address=192.168.56.30 ; done;' -i hosts.ini -b
ansible bash -m shell -a 'for i in {1..20} ; do wget 127.0.0.1/my.html ; done;' -i hosts.ini -b
ansible bash -m shell -a 'for i in {1..3} ; do wget 127.0.0.1/index.html ; done;' -i hosts.ini -b
```
### Проверка
```
wait crontab job executing...
vagrant ssh
sudo -i
mail
1
n
n
n
```
#### [bash.out](https://github.com/serjb1973/bash/blob/main/bash.out)

