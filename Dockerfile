# ---- Base Node ----
FROM alpine:3.5 AS base

# install node
RUN apk add --no-cache nodejs-current curl tar

ENV YARN_VERSION 1.7.0

RUN mkdir /opt

# install Yarn
RUN curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
    && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
    && ln -snf /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
    && ln -snf /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
    && rm yarn-v$YARN_VERSION.tar.gz

# set working directory
WORKDIR /usr/src/app

# copy project file
COPY package*.json .


# ---- Dependencies ----
FROM base AS dependencies

# install node packages
RUN npm set progress=false && npm config set depth 0
RUN npm install --only=production

# copy production node_modules aside
RUN cp -R node_modules prod_node_modules

# install ALL node_modules, including 'devDependencies'
RUN npm install

# ---- Test ----
# run setup and tests
FROM dependencies AS test

COPY . .

RUN npm run setup && npm run test


# ---- Release ----
FROM base AS release

# copy production node_modules
COPY --from=dependencies /usr/src/app/prod_node_modules ./node_modules

# copy app sources
COPY . .

# expose port and define CMD
EXPOSE 8080

CMD npm run start
