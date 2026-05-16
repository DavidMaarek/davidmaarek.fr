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

# Copie l'index + tous les assets statiques (css/, fonts/, img/, tools/).
# Le .dockerignore exclut .git, .github, .idea, README.md du COPY ci-dessous
# pour ne pas polluer l'image runtime.
COPY . /usr/share/nginx/html

EXPOSE 80
