FROM node:alpine

RUN mkdir -p /sms-auth
WORKDIR /sms-auth

ADD . .

RUN npm install

EXPOSE 3000

CMD ["npm", "start"]