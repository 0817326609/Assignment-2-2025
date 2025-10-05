# 🚌 Smart Public Transport Ticketing System

This is a distributed microservices system built with **Ballerina**, **Kafka**, and **MongoDB** to simulate real-world public transport ticketing and validation workflows.

## 🚀 Microservices
- **Passenger Service** – User registration and ticket booking.
- **Ticketing Service** – Manages ticket lifecycle.
- **Payment Service** – Confirms payments and emits Kafka events.
- **Validator Service** – Scans and validates tickets.
- **Notification Service** – Sends passenger updates.
- **Admin Service** – Manages routes and disruptions.

## 🧩 Dependencies
- Kafka & ZooKeeper
- MongoDB
- Docker & Ballerina ≥ 2201.9.0

## ⚙️ Setup
```bash
make dev-up
