import ballerina/io;
import ballerinax/kafka;

kafka:Consumer consumer = check new (kafka:ConsumerConfiguration {
    bootstrapServers: "kafka:9092",
    groupId: "notification-group",
    topics: ["ticket.validated", "schedule.updates"]
});

service on consumer {
    resource function onMessage(kafka:ConsumerRecord[] records) {
        foreach var rec in records {
            io:println("📢 Notification event received: ", rec.value.toString());
        }
    }
}
