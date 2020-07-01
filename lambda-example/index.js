// 'Hello World' nodejs runtime AWS Lambda function
exports.handler = (event, context, callback) => {
  console.log('Hello, logs!');
  callback(null, 'great success');
};
