import boto3

s3 = boto3.client(
    's3',
    region_name='us-east-1',  # Replace with your desired region
    
)
# Upload a file to S3
result = s3.put_object(
    Bucket='bucketdemoarja1',  # Replace with your bucket name
    Key='testfrompython.txt',  # Name of the file in S3
    Body='This is a test upload from Python'  # Content of the file
)
print("Uploading to S3.....")
print(result)