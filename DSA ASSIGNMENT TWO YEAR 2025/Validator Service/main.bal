import ballerina/http;
import ballerina/io;
import ballerinax/kafka;

kafka:Producer producer = check new (kafka:ProducerConfiguration {
    bootstrapServers: "kafka:9092"
});

service /validate on new http:Listener(8080) {
    resource function post .(http:Caller caller, http:Request req) returns error? {
        json payload = check req.getJsonPayload();
        io:println("✅ Ticket validated: ", payload.toJsonString());

        // Publish event for notification
        check producer->send({
            topic: "ticket.validated",
            value: payload.toJsonString()
        });

        check caller->respond({ status: "validated" });
    }
}
