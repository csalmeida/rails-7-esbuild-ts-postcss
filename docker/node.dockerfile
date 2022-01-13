# This image makes use of a Node image running on Linux Alpine (latest versions of both)
# Using digest SHA256 increases security
FROM node:lts@sha256:d87a1f3e0b5b2a684aa101fb7259913a13372626aa1de17398d657bf3d539df2

# Adds a package to act as PID 1 so that Node doesn't take that place
# Node wasn't built to run as PID 1 and avoiding it prevents unexpected behaviour
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_amd64.deb

RUN dpkg -i dumb-init_*.deb

# A work directory is required to be used by npm install
WORKDIR /app/

# Copy all project files to the container
# Files in the location of this file are copied to WORKDIR in the container
# Scopes permissions to user node instead of root
COPY --chown=node:node . .

# Install dependencies
RUN yarn install --frozen-lockfile

# Switches user from root to node
USER node

# The process this container should run
CMD ["dumb-init", "yarn", "run", "dev"]