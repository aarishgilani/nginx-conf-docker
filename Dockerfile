# Create a base to build the Laravel app
# Alpine is a lightweight linux distro which works pretty good with nginx
FROM nginx:stable-alpine

# Creating variables to avoid resuing code
ENV NGINXUSER=laravel
ENV NGINXGROUP=laravel

# Folder to which our 'site source' will be attached to
# I believe we will create a link between files on our local machine and docker container
# The folder being created here will be attached to source files on our host machine
RUN mkdir -p /var/www/html/public

# This copies new files, directories or remote files from <src> and adds them to the image at the path <dest>
ADD nginx/default.conf /etc/nginx/conf.d/default.conf

# What user the nginx process runs for
# sed = seed editor / text transform utility in linux
# www-data is the default user in alpine linux
RUN sed -i "s/user www-data/user ${NGINXUSER}/g" /etc/nginx/nginx.conf

# Attach the new user to the apline linux shell
RUN adduser -g  ${NGINXGROUP} -s /bin/sh -D ${NGINXUSER}

# In docker volumes are virtual mounted file systems that connect the files and directories from host machine docker is running on to ones in specific containers.