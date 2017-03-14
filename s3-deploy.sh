# This file is passed evironment variables AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, 
# APP_HOME=bamboo.build.working.directory and planName=bamboo.shortPlanName by Bamboo.

planName=$(echo "$planName" | tr '[:upper:]' '[:lower:]') # S3 bucket names can't have capital letters.

echo "plan name: ${planName}"

newBucket=False
if [ -z "$planName" ] || [ "$planName" = "dev portal" ]
then 
    echo "deploying master to production..."
    bucket_name=dev.beanstream.com
else
    echo "deploying branch to test..."
    bucket_name="dev.beanstream.com.${planName}"
    
    if aws s3 ls "s3://${bucket_name}" 2>&1 | grep -q 'NoSuchBucket'
    then
        echo "Bucket doesn't exist. Creating bucket..."
        newBucket=true
        aws s3 mb "s3://${bucket_name}"
    fi
fi


echo "Syncing to bucket..."
aws s3 sync --delete --exact-timestamps $APP_HOME/build s3://${bucket_name}

# S3 Bucket Policy 
policy="{
	\"Version\": \"2012-10-17\",
	\"Statement\": [
		{
			\"Sid\": \"AddPerm\",
			\"Effect\": \"Allow\",
			\"Principal\": \"*\",
			\"Action\": [
			    \"s3:GetObject\"
			],
			\"Resource\": \"arn:aws:s3:::${bucket_name}/*\"
		}
	]
}"


if [ "$newBucket" = true ]
then
    echo "Enabling static website and adding bucket policy..."
    aws s3 website "s3://${bucket_name}" --index-document index.html
    aws s3api put-bucket-policy --bucket "${bucket_name}" --policy "${policy}"    
fi