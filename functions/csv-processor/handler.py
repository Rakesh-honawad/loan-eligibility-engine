import json

def process(event, context):
    try:
        record = event['Records'][0]
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        
        print(f"CSV uploaded: {bucket}/{key}")
        print(f"Full event: {json.dumps(event)}")
        
        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'CSV upload event received - ready for n8n processing',
                'bucket': bucket,
                'key': key
            })
        }
    except Exception as e:
        print(f'Error: {e}')
        import traceback
        traceback.print_exc()
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }