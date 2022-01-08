	locals {
		lambda-zip-location = "outputs/my_function.zip"
	}

	data "archive_file" "init" {
	  type        = "zip"
	  source_file = "my_function.py"
	  output_path = local.lambda-zip-location
	}

	resource "aws_lambda_function" "test_lambda" {
	  filename      = local.lambda-zip-location
	  function_name = "my_function"
	  role          = aws_iam_role.my_lambda_iam_role.arn
	  handler       = "my_function.my_lamda_function"
		
	  #source_code_hash = filebase64sha256("locals.lambda-zip-location")	
		
	  runtime = "python3.7"
	  
	}