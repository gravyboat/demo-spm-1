nginx_user:
  user.present:
    - name: nginx
    - system: True
    - shell: /sbin/nologin
    - groups:
      - nginx
    - require:
      - group: nginx

nginx_group:
  group.present:
    - name: nginx
    - system: True

install_nginx:
  pkg.installed:
    - name: nginx
    - skip_suggestions: True

nginx_log_dir:
  file.directory:
    - name: /var/log/nginx
    - user: nginx
    - group: root
    - mode: 0755

www_dir:
  file.directory:
    - name: /var/www
    - user: root
    - group: root
    - mode: 755

remove_nginx_default_conf:
  file.absent:
    - name: /etc/nginx/conf.d/default.conf

remove_nginx_virtual_conf:
  file.absent:
    - name: /etc/nginx/conf.d/virtual.conf

remove_nginx_ssl_conf:
  file.absent:
    - name: /etc/nginx/conf.d/ssl.conf

nginx_service:
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      - user: nginx_user
