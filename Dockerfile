FROM python:3.11

# Set build directory
WORKDIR /tmp

# Copy files necessary for build
COPY . .

RUN apt-get update
RUN apt-get -y install libcairo2-dev libfreetype6-dev libffi-dev libjpeg-dev libpng-dev libz-dev

RUN pip install mkdocs-material
RUN pip install 'mkdocs-material[imaging]'

# Expose MkDocs development server port
EXPOSE 8000

# Start development server by default
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]