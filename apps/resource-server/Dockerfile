FROM node:10.4.0-alpine
# FROM node:10.4.0
# ^ This has more default utilities available for debugging (bash, patch, etc)

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

# RUN patch node_modules/express-jwt/lib/index.js < express-jwt-index.js.patch
# RUN cat node_modules/express-jwt/lib/index.js
# ^ Commands that can be run to eval node_module code that had been customized to use console.log for debugging

EXPOSE 8080
CMD [ "npm", "start" ]
