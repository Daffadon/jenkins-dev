FROM node:14-alpine

# Set the working directory
WORKDIR /app

COPY package.json ./
RUN npm ci

COPY . .

RUN npm build

# Start the Next.js application
CMD ["npm", "start"]