# Usar la imagen oficial de Nginx
FROM nginx:latest

# Remover la configuración por defecto de Nginx
RUN rm /usr/share/nginx/html/index.html

# Crear la página de "Hola Mundo"
RUN echo '<!DOCTYPE html><html><head><title>Hola Mundo</title></head><body><h1>Hola Mundo</h1></body></html>' > /usr/share/nginx/html/index.html

# Exponer el puerto 80
EXPOSE 80

# Iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
