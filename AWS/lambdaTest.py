# This Lambda function echoes back the input it receives. 
# This can be used for testing purposes to ensure the communication between 
# your frontend and backend is working correctly.

def lambda_handler(event, context):
    try:
        # Extract the uploaded file content from the Lambda event
        file_content = event['body']

        # For testing purposes, you can simply echo back the content
        return {
            'statusCode': 200,
            'body': file_content
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': f'Error: {str(e)}'
        }
