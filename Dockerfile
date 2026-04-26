FROM node:20-alpine AS builder

WORKDIR /app/frontend

COPY frontend/package*.json ./
RUN npm ci

COPY frontend ./
RUN npm run build

# ---------- Backend ----------
FROM node:20-alpine

WORKDIR /app/backend

COPY backend/package*.json ./
RUN npm ci

COPY backend ./

# Copy frontend build from builder
COPY --from=builder /app/frontend/dist ../frontend/dist

EXPOSE 5000

CMD ["node", "server.js"]