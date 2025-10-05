import ballerina/http;
import ballerina/io;
import ballerinax/mongodb;
import ballerinax/kafka;

mongodb:Client ticketDb = check new ("mongodb://mongo:27017", "tickets");
kafka:Producer producer = check new (kafka:ProducerConfiguration {
    bootstrapServers: "kafka:9092"
});

service /tickets on new http:Listener(8080) {
    resource function post .(http:Caller caller, http:Request req) returns error? {
        json data = check req.getJsonPayload();
        check ticketDb->insert("tickets", data);
        io:println("🎫 Ticket created: ", data.toJsonString());

    
        check producer->send({
            topic: "ticket.requests",
            value: data.toJsonString()
        });

        check caller->respond({ message: "Ticket created", data: data });
    }
}

