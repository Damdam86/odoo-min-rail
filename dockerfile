FROM odoo:18.0

USER root

# Installation des dépendances supplémentaires
RUN apt-get update && apt-get install -y \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copie des fichiers de configuration
COPY ./odoo.conf /etc/odoo/
COPY ./addons /mnt/extra-addons

# Permissions
RUN chown -R odoo:odoo /mnt/extra-addons
RUN chown odoo:odoo /etc/odoo/odoo.conf

USER odoo

# Port d'écoute Railway
EXPOSE 8069

# Commande de démarrage
CMD ["odoo", "-c", "/etc/odoo/odoo.conf"]
