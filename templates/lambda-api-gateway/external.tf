data "archive_file" "zip_lambda_function" {
    type        = "zip"
    source_dir  = "lambda_function/"
    output_path = "lambda_function.zip"

}
