data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnet_ids" "default_subnets" {
  vpc_id = data.aws_vpc.default_vpc.id
}

data "aws_subnet" "subnets" {
  count = length(data.aws_subnet_ids.default_subnets.ids)
  id    = data.aws_subnet_ids.default_subnets.ids[count.index]
}

