resource "aws_iam_role_policy" "my_lambda_policy" {
  name = "my_lambda_policy"
  role = aws_iam_role.my_lambda_iam_role.id

  policy = file("iam-role/my_lambda_function_policy.json")
  
}

resource "aws_iam_role" "my_lambda_iam_role" {
  name = "my_lambda_iam_role"

  assume_role_policy = file("iam-role/lambda-assume-policy.json")
  
}