# Makefile for Smart Ticketing System

dev-up:
	docker compose -f docker-compose.yml -f docker-compose.override.yml up --build -d

down:
	docker compose down

logs:
	docker compose logs -f --tail=50

health:
	curl -s http://localhost:8081/health && echo "" || echo "Passenger service down"
	curl -s http://localhost:8082/health && echo "" || echo "Ticketing service down"
	curl -s http://localhost:8083/health && echo "" || echo "Payment service down"
	curl -s http://localhost:8084/health && echo "" || echo "Validator service down"

reset:
	docker compose down -v
	docker system prune -f
	rm -rf mongo_data

test:
	for dir in passenger-service ticketing-service payment-service validator-service; do \
		docker compose run --rm $$dir bal test; \
	done

redeploy:
	docker compose up --build -d
