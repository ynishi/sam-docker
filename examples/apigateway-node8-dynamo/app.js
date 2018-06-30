const AWS = require('aws-sdk');

AWS.config.update({
    region: 'us-west-2',
    endpoint: process.env['DYNAMO_ENDPOINT'],
});
const docClient = new AWS.DynamoDB.DocumentClient();

const asyncAwaitGet = async () => {
    let params = {
        TableName: 'Music',
        Key: {
            Artist: 'No One You Know',
            SongTitle: 'Call Me Today',
        },
    };
    const musicData = await docClient.get(params).promise();
    console.log(musicData);
    const response = {
        'statusCode': 200,
        'body': JSON.stringify({
            message: 'hello world',
            data: musicData.Item,
        }),
    };
    return response;
};

exports.lambda_handler = async (event, context, callback) => {
    try {
        const response = await asyncAwaitGet();
        console.log(response);
        callback(null, response);
    } catch (err) {
        console.error(err);
        callback(err, null);
    }
};
