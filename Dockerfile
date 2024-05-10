FROM node:20-alpine3

WORKDIR /app
RUN apk add git
RUN git clone -b main https://github.com/Daffadon/jenkins-dev.git .  
RUN npm ci

RUN npm build

# Start the Next.js application
CMD ["npm", "start"]