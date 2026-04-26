FROM node:20-alpine AS builder

WORKDIR /app/frontend

COPY frontend/package*.json ./
RUN cd frontend && npm ci

COPY frontend ./
RUN npm run build


FROM node:20-alpine

WORKDIR /app/backend

COPY backend/package*.json ./
RUN cd backend && npm ci

COPY backend ./

COPY --from=builder /app/frontend/dist ../frontend/dist

EXPOSE 5000

CMD ["node", "server.js"]