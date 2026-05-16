# =============================================================================
# davidmaarek.fr — Site statique (HTML/CSS pur) servi par nginx.
#
# Pas de build step (Node, npm…) : on COPY directement les sources dans
# l'image nginx. C'est un site CV, pas une SPA, donc rien à compiler.
#
# Taille finale : ~10 MB (nginx-alpine + ~200 KB d'assets).
# =============================================================================

FROM nginx:1.27-alpine

# Remplace la config par défaut de nginx (qui sert /usr/share/nginx/html
# en mode "listing de fichier" sans nos règles 404/cache) par la nôtre.
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copie le contenu du site dans /usr/share/nginx/html.
#
# Liste explicite plutôt qu'un `COPY . /usr/share/nginx/html` : sinon les
# fichiers d'infra (Dockerfile, nginx.conf, .gitignore, .github, etc.) se
# retrouveraient dans le webroot et seraient potentiellement servis publiquement
# à des URLs comme `/Dockerfile`. Ici on copie uniquement ce qui doit être
# accessible publiquement.
#
# Si un nouveau dossier top-level est ajouté au repo (genre `articles/`), il
# faudra ajouter une ligne COPY ici pour qu'il soit servi.
COPY index.html /usr/share/nginx/html/
COPY css       /usr/share/nginx/html/css
COPY fonts     /usr/share/nginx/html/fonts
COPY img       /usr/share/nginx/html/img
COPY tools     /usr/share/nginx/html/tools

EXPOSE 80
