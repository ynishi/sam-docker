const AWS = require("aws-sdk");
let response;

AWS.config.update({
    region: "us-west-2",
    endpoint: process.env["DYNAMO_ENDPOINT"] 
});
const docClient = new AWS.DynamoDB.DocumentClient();

var params = {
    TableName: "Music",
    Key: {
        Artist: "No One You Know",
        SongTitle: "Call Me Today"
    }
}

exports.lambda_handler = async (event, context, callback) => {
    try {
        const res = await docClient.get(params).promise();
        response = {
            'statusCode': 200,
            'body': JSON.stringify({
                message: 'hello world',
                data: res
            })
        };
        console.log(res);
        callback(null, response);
    } catch (err) {
        console.error(err);
        callback(err, null);
    }
};
