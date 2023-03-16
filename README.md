# Windows onec ansible roles

Ansible roles for deployment onec on windows system.

## Requirements

### Ansible
It was tested on the following versions:
 * 2.8
 * 2.9

### Operating systems

Tested with Win10, Ws2019, Ws2022.

## Example Playbooks

### Deploy onec server

```
---
- name: deploy onec server
  hosts: onec-servers
  vars_files:
    - secrets.yml
  pre_tasks:
    - name: create ansible temp directory
      win_file:
        path: "{{ ansible_win_temp_dir }}"
        state: directory
        ignore_errors: true
  roles:
    - role: onec-server
      v8version: "8.3.16.1148"
```

Run
```
$ ansible-playbook ansible-onec-windows/onec-server.yml
```

To find and remove onec and RAS services set
```
onec_server_find_services: yes
```

To copy nethasp.ini from templates set
```
copy_nethasp_ini: yes
```

### Deploy onec web components on web server

```
---
- name: deploy onec web components
  hosts: test
  vars_files:
    - secrets.yml
  roles:
    - role: onec-webserver
      v8version: "8.3.16.1148"
      onec_architecture: "x86"
      update_web_config: true
      prev_v8version: "8.3.15.1656"

```

Run
```
$ ansible-playbook ansible-onec-windows/onec-webserver.yml
```

To update v8verson in web.config set
```
prev_v8version: "8.3.15.1656"
update_web_config: true
```

## Ошибки и их решения

### Ошибка при подключении к удаленному хосту:

Текст ошибки:
```
credssp: Server did not response with a CredSSP token after step Step 5. Delegate Credentials - actual 'Negotiate, Kerberos, CredSSP'"
```

Способ устранения:
1) Проверить что у пользователя под которым идет подключение есть доступ к серверу

Если не помогло:

2) Выполнить на удаленном хосте
```ps1
winrm set winrm/config/service/auth '@{CredSSP="true"}'
winrm set winrm/config/client/auth '@{CredSSP="true"}'
Enable-WSManCredSSP -Role Server
```
