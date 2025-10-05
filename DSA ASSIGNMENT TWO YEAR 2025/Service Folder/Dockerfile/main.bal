import ballerina/http;
import ballerina/io;
import ballerinax/mongodb; 

service /passengers on new http:Listener(8080) {
    resource function post .(http:Caller caller, http:Request req) returns error? {
        json data = check req.getJsonPayload();
        io:println("Passenger created: ", data.toJsonString());
        check caller->respond({ message: "Passenger created", data: data });
    }
}
