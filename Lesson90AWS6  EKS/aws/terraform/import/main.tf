resource "aws_iam_user" "lb" {
    name = "arya-stark"
}


resource "aws_iam_user" "instructor" {
  name = "instructor"
  tags = {
    person = "instructor"
  }
}

resource "aws_db_instance" "mysql_manual" {
  instance_class = "db.t3.micro"
}

