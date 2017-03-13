# Clean up deployed branch buckets on s3. Should be run periodically.  

aws s3api list-buckets --query 'Buckets[].Name' | grep -o '"[^"]*"' | tr -d '"' | grep "dev\.beanstream\.com\." > bucket_names.txt

echo "Deleting old buckets..."

# Whitelisted buckets (don't delete)
echo "dev.beanstream.com.staging\n
dev.beanstream.com.roboto\n
dev.beanstream.com.carelesswhisper" > whitelist.txt

for bucket_name in `cat bucket_names.txt`; do
    should_delete="true"
    for whitelisted_bucket in `cat whitelist.txt`; do 
        if [ "$whitelisted_bucket" = "$bucket_name" ]; then 
            should_delete="false"
        fi
    done 
    
    if [ "$should_delete" = "true" ]; then
        echo "Deleting bucket $bucket_name..."
        # aws s3 rb "s3://${bucket_name}" --force
    fi
done
