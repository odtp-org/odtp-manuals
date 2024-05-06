FROM python:3.11

# Set build directory
WORKDIR /tmp

# Copy files necessary for build
COPY . .

RUN apt-get update

RUN pip install mkdocs-material mkdocs-link-marker

# Expose MkDocs development server port
EXPOSE 8000

# Start development server by default
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]