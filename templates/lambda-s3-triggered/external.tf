data "archive_file" "zip_lambda_function" {
    type        = "zip"
    source_dir  = "lambda_functions/"
    output_path = "lambda_functions.zip"

}
