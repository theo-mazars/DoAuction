FROM buildkite/puppeteer:8.0.0
WORKDIR /app/scraper

COPY . .
RUN yarn && npx prisma generate
CMD [ "yarn", "start" ]
