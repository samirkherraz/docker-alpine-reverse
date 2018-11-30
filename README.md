# NGINX Reverse Proxy on Alpine Linux + S6 Overlay

# Auto configuration parameters :

- CERTBOT_EMAIL=admin@exemple.org ( Email used by certbot )
- SITE_{NUM}_ENABLE=YES ( Is this site enabled ? )
- SITE_{NUM}_DOMAIN=ldap.exemple.org ( Domain/Subdomain )
- SITE_{NUM}_DOMAIN_PATH=/ ( if this is /cloud then we will access ldap.exemple.org/cloud  )
- SITE_{NUM}_HOST=fusiondirectory ( the service name to bind )
- SITE_{NUM}_HOST_PROTO=http 
- SITE_{NUM}_HOST_PORT=80
- SITE_{NUM}_HOST_PATH=/ ( if this is /cloud then we will access fusiondirectory/cloud  )
- SITE_{NUM}_CERBOT=YES ( Should CERTBOT need try to certificate this site )

# Compose file exemple

```

version: '3.1'

services:

  reverse:
    image: samirkherraz/reverse
    environment:
      - CERTBOT_EMAIL=admin@exemple.org
      - SITE_0_ENABLE=YES
      - SITE_0_DOMAIN=ldap.exemple.org
      - SITE_0_DOMAIN_PATH=/
      - SITE_0_HOST=fusiondirectory
      - SITE_0_HOST_PROTO=http
      - SITE_0_HOST_PORT=80
      - SITE_0_HOST_PATH=/
      - SITE_0_CERBOT=YES
    ports:
      - 443:443
      - 80:80
    volumes:
      - reverse-certdata:/etc/letsencrypt/
      - reverse-config:/etc/nginx/
    networks:
      default:
    deploy:
      resources:
        limits:
          memory: 256M
      restart_policy:
        condition: on-failure
      mode: global


  fusiondirectory:
    image: samirkherraz/fusiondirectory
    environment:
      - ADMIN_PASS=password
      - CONFIG_PASS=password
      - DOMAIN=exemple.org
      - FD_ADMIN=fd-admin
      - FD_PASS=password
      - INSTANCE=exemple
    ports:
      - 8000:80
      - 389:389
    volumes:
      - openldap-data:/var/lib/openldap/
      - openldap-config:/etc/openldap/
    networks:
      default:
    deploy:
      resources:
        limits:
          memory: 256M
      restart_policy:
        condition: on-failure
      mode: global



volumes:
    reverse-certdata:
    reverse-config:
    openldap-data:
    openldap-config:

```