import ballerina/http;
import ballerina/io;
import ballerinax/kafka;

kafka:Producer producer = check new (kafka:ProducerConfiguration {
    bootstrapServers: "kafka:9092"
});

service /payments on new http:Listener(8080) {
    resource function post .(http:Caller caller, http:Request req) returns error? {
        json data = check req.getJsonPayload();
        io:println("💰 Payment processed: ", data.toJsonString());

        // Publish confirmation
        check producer->send({
            topic: "payments.processed",
            value: data.toJsonString()
        });

        check caller->respond({ message: "Payment confirmed", data: data });
    }
}
