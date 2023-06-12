FROM public.ecr.aws/lambda/python:3.9-arm64

# Install the function's dependencies using file requirements.txt
COPY lambda_function/requirements.txt .
RUN  pip install -r requirements.txt

# Create directories
RUN mkdir src
RUN touch src/__init__.py

# Copy source code
COPY src/. src/.
COPY lambda_function/app.py src/.

# Define PYTHONPATH
ENV PYTHONPATH src

# Set the CMD to the handler
CMD [ "src.app.lambda_handler" ]