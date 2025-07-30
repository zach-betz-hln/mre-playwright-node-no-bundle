ARG NODE_IMAGE=node:22-alpine
ARG PLAYWRIGHT_IMAGE=mcr.microsoft.com/playwright:v1.54.1-noble

FROM ${NODE_IMAGE} AS production-dependencies
COPY package*.json /app/
WORKDIR /app
RUN npm ci --omit=dev

FROM ${NODE_IMAGE} AS build
COPY . /app/
WORKDIR /app
RUN npm ci \
  && npm run build

FROM ${PLAYWRIGHT_IMAGE} AS final
COPY package*.json /app/
COPY --from=production-dependencies /app/node_modules /app/node_modules
COPY --from=build /app/dist /app/dist
WORKDIR /app
CMD ["npm", "run", "start"]
