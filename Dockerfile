# ---- Base Node ----
FROM node:10.5.0-alpine AS base

# set working directory
WORKDIR /usr/src/app

# copy project file
COPY package*.json .


# ---- Dependencies ----
FROM base AS dependencies

# install node packages
RUN yarn install --production=true

# copy production node_modules aside
RUN cp -R node_modules prod_node_modules

# install ALL node_modules, including 'devDependencies'
RUN yarn install

# ---- Test ----
# run setup and tests
FROM dependencies AS test

COPY . .

# yarn run test -o --watch
RUN yarn run format && yarn run lint && yarn run test


# ---- Release ----
FROM base AS release

# copy production node_modules
COPY --from=dependencies /usr/src/app/prod_node_modules ./node_modules

# copy app sources
COPY . .

# expose port and define CMD
EXPOSE 8080

CMD yarn run api
