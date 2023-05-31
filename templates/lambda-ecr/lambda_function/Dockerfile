FROM public.ecr.aws/lambda/python:3.9-arm64

# Install the function's dependencies using file requirements.txt
COPY requirements.txt .
RUN  pip install -r requirements.txt

# Copy lambda function
COPY app.py .

# Set the CMD to your handler
CMD [ "app.lambda_handler" ]