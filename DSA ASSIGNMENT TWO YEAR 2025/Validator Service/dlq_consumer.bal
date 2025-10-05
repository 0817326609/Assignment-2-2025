import ballerina/io;
import ballerinax/kafka;

kafka:Consumer dlqConsumer = check new (kafka:ConsumerConfiguration {
    bootstrapServers: "kafka:9092",
    groupId: "validator-dlq",
    topics: ["ticket.errors"]
});

service on dlqConsumer {
    resource function onMessage(kafka:ConsumerRecord[] recs) {
        foreach var rec in recs {
            io:println("🔁 Retrying failed ticket validation: ", rec.value.toString());
        }
    }
}
