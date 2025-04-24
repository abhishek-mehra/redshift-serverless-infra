-- study 1

- to create folders in s3 for study 1 config , glue scripts
 aws s3 cp empty.txt s3://redshift-secure-data-lake-104334887604/study1/raw/.keep && \
aws s3 cp empty.txt s3://redshift-secure-data-lake-104334887604/study1/processed/.keep && \
aws s3 cp empty.txt s3://redshift-secure-data-lake-104334887604/scripts/study1/.keep && \
aws s3 cp empty.txt s3://redshift-secure-data-lake-104334887604/configs/.keep && \
aws s3 cp empty.txt s3://redshift-secure-data-lake-104334887604/glue-temp/.keep && \
aws s3 cp empty.txt s3://redshift-secure-data-lake-104334887604/spark-events/.keep
upload: ./empty.txt to s3://redshift-secure-data-lake-104334887604/study1/raw/.keep
upload: ./empty.txt to s3://redshift-secure-data-lake-104334887604/study1/processed/.keep
upload: ./empty.txt to s3://redshift-secure-data-lake-104334887604/scripts/study1/.keep
upload: ./empty.txt to s3://redshift-secure-data-lake-104334887604/configs/.keep
upload: ./empty.txt to s3://redshift-secure-data-lake-104334887604/glue-temp/.keep
upload: ./empty.txt to s3://redshift-secure-data-lake-104334887604/spark-events/.keep