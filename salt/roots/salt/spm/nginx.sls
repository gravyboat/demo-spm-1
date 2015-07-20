include:
  - nginx

spm_directory:
  file.directory:
    - name: /srv/spm
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

spm_nginx_conf:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://spm/files/nginx.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: install_nginx

spm_nginx_conf_d:
  file.managed:
    - name: /etc/nginx/conf.d/spm.conf
    - source: salt://spm/files/spm.conf.jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: install_nginx
    - watch_in:
      - service: nginx_service

selinux_permissive_mode:
  file.managed:
    - name: /etc/selinux/config
    - source: salt://spm/files/selinux.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: install_nginx

stop_iptables:
  service.dead:
    - name: iptables
    - enable: False
