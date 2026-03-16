from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()
sampleList = [10, 11, 22, 23, 34, 35, 40, 45, 60]
sampleRdd = spark.sparkContext.parallelize(sampleList)
sampleRdd.first()
