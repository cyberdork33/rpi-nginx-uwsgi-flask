# rpi-nginx-uwsgi-flask
Docker container for hosting python Flask apps on Raspberry Pi using nginx and uWSGI.
* This relies on python3.
* nginx is only set up to serve on port 80; if you want SSL (which you should) either drop in a new app.conf nginx config, or run an SSL proxy in front of it.

### Building on Raspberri Pi
This image is set up for building on a 32-bit Rasbian.

## Usage

This container is not meaningful on its own; it needs to have your Flask app installed in it.  See the example directory for a fully working sample.

To create a container for your Flask app:

1. Create a ```uwsgi-app.ini``` in your application directory with the name of the module and app variable. For instance, a ```main.py``` with the Flask instance named ```app``` would mean the ini file would contain this:

    ```ini
    [uwsgi]
    module = main
    callable = app
    ```

2. Make sure your application prerequisites are saved in a standard ```requirements.txt``` in your application directory.

3. Copy your application directory to a subdirectory of the docker build directory.

4. Create a Dockerfile to build a container from this one, with your app and requirements:

    ```Dockerfile
    FROM cyberdork33/rpi-nginx-uwsgi-flask:latest
    COPY myappdirectory /app
    RUN pip install -U -r /app/requirements.txt
    ```

6. Build and run your container, forwarding the container port 80 to wherever you want it on your container host. For instance, to forward to port 8080:

    ```Shell
    docker build -t myapp .
    docker run -p 8080:80 myapp
    ```

Now if you visit https://hostIP:8080/ in your browser you should see your Flask app.
