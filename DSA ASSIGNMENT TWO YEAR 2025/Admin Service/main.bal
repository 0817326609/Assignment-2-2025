import ballerina/http;
import ballerina/io;
import ballerinax/mongodb;
import ballerinax/kafka;

mongodb:Client adminDb = check new ("mongodb://mongo:27017", "admin");
kafka:Producer producer = check new (kafka:ProducerConfiguration {
    bootstrapServers: "kafka:9092"
});

service /admin on new http:Listener(8080) {
    resource function post /routes(http:Caller caller, http:Request req) returns error? {
        json route = check req.getJsonPayload();
        check adminDb->insert("routes", route);
        io:println("🛣️ Route created: ", route.toJsonString());
        check caller->respond({ message: "Route saved", route: route });
    }

    resource function post /notify(http:Caller caller, http:Request req) returns error? {
        json data = check req.getJsonPayload();
        io:println("⚠️ Admin update broadcast: ", data.toJsonString());
        check producer->send({
            topic: "schedule.updates",
            value: data.toJsonString()
        });
        check caller->respond({ status: "Update sent" });
    }
}
