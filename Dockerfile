FROM node:14-alpine

WORKDIR /app
RUN apk install git
RUN git clone -b main https://github.com/Daffadon/jenkins-dev.git .  
RUN npm ci

RUN npm build

# Start the Next.js application
CMD ["npm", "start"]