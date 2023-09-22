# Multi-User GitHub (mgh) Script


! git only, IDE support not tested, may not work

This script is designed to handle multiple GitHub users on the same machine. It can comment out the existing configuration, authenticate a new user, swap between users, show all existing user configurations, and initialize a backup file for the current user in the `hosts.yml` file.

----

! только git, с IDE не дружит вроде, зависит от IDE

Этот скрипт предназначен для работы с аккаунтами GitHub на одной машине. Он может закомментировать существующую конфигурацию, аутентифицировать нового пользователя, переключаться между ними, показывать всех существующих и создавать резервную копию файла для текущего пользователя в файле `hosts.yml`.

## Requirements

OS: Linux / WSL / MacOS*

(*) I didn't test MacOS / Я не проверял MacOS

Install github cli / Установить github cli:

https://github.com/cli/cli#installation

## Installation

1. Clone this repository / Склонировать репозиторий:
```bash
git clone https://github.com/kyoukisu/mgh
cd ./mgh
```

2. Make executable / Сделать файл исполняемым:
```bash
chmod +x mgh.sh
```

3. Add to your PATH / Добавить в PATH:
```bash
sudo cp $(pwd)/mgh.sh /usr/local/bin/mgh
```

(*) Removal / Удаление
```bash
sudo rm /usr/local/bin/mgh
```

## Usage

![Alt text](https://media.discordapp.net/attachments/919612017998962718/1154677902311432192/image.png?width=1919&height=404)

![Alt text](https://media.discordapp.net/attachments/919612017998962718/1154677918123958313/image.png?width=1919&height=362)

![Alt text](https://media.discordapp.net/attachments/919612017998962718/1154677933395427430/image.png?width=1919&height=234)

Following commands are available :

- `mgh auth` - Backs up the current hosts file, then attempts to log in (use https) and set up git. If login fails, restores the hosts file from the backup.

- `mgh swap USERNAME` - Replaces the current hosts file with the file named hosts_USERNAME.yml, then attempts to setup git.

- `mgh lists` - Lists all usernames that have backup files.

-----

Доступны следующие команды:

- `mgh auth` - Сохраняет текущий файл с хостами, пытается войти (используя https) и настраивает git. Если вход не удается, возвращает файл с хостами из резервной копии.

- `mgh swap USERNAME` - Заменяет текущий файл с хостами файлом с именем hosts_USERNAME.yml, потом пытается настроить git.

- `mgh lists` - Показывает всех пользователей, для которых есть резервные файлы.

## Potential Errors

- "Error: No write permissions for hosts.yml": The script doesn't have the necessary permissions to modify the `hosts.yml` file. You can fix this by changing the permissions of the file with `chmod`.

- "gh auth login failed, restoring the original file": The login attempt failed. Check that your GitHub credentials are correct.

- "File hosts_USERNAME.yml does not exist.": The specified user's backup file does not exist. Check that the backup file exists and that you have the correct username.

Remember to check the script's output for any other errors that might occur during execution, such as missing dependencies or commands.

----

- "Error: No write permissions for hosts.yml": Скрипт не имеет нужных прав для изменения файла hosts.yml. Это можно исправить, изменив права файла с помощью chmod.

- "gh auth login failed, restoring the original file": Попытка входа не удалась. Проверьте правильность учетных данных GitHub.

- "File hosts_USERNAME.yml does not exist.": Резервного файла для указанного пользователя нет. Убедитесь, что такой файл существует и имя пользователя указано верно.

Не забудьте проверить вывод скрипта на наличие других ошибок, которые могут возникнуть во время выполнения, например, отсутствующих зависимостей или команд.

