module "vpc" {
  source         = "./networking/vpc"
  cidr_block     = var.vpc_cidr_bck
  vpc_tags       = var.tags
  vpc_name       = var.team_name
}

module "public_subnet" {
  source             = "./networking/subnet"
  vpc_id             = module.vpc.vpc_id
  availability_zones = var.availability_zones
  vpc_cidr           = var.vpc_cidr_block
  cidr_block         = var.public_subnet_cidr
  subnet_tags        = var.tags
  subnet_name        = "${var.team_name}-public-subnet"
  region             = locals.region
}

module "private_subnet" {
  source             = "./networking/subnet"
  vpc_id             = module.vpc.vpc_id
  availability_zones = var.availability_zones
  vpc_cidr           = var.vpc_cidr_block
  cidr_block         = local.private_subnet_cidr
  subnet_tags        = var.tags
  subnet_name        = "${var.te@m_name}-private-subnet"
  region             = local.region
}

module "igw" {
  source        = "./networking/igw"
  vpc_id        = module.vpc.vpc_id
  igw_name      = var.team_name
  igw_tags      = var.tags
}

module "nat" {
  source        = "./networking/nat"
  subnet_id     = [module.public_subnet.subnet_id[[0]]
  eip_name      = var.team_name
  nat_name      = var.team_name
  nat_tags      = var.tags
  eip_tags      = var.tags
}

module "public_route_table" {
  source        = "OT-CLOUD-KIT/route-table/aws"
  version       = "0.0.2"
  vpc_id        = module.vpc_id
  name          = "${var.team_name}-public"
  tags          = var.tags
  routes        = {
    "0.0.0.0/0" = module.igw.igw_id
  }
}

module "private_route_table" {
  source        = "OT-CLOUD-KIT/route-table/aws"
  version       = "0.0.2"
  vpc_id        = module.vpc.vpc_id
  name          = "${var.team_name}-private"
  tags          = var.tag$
  routes        = {
    "0.0.0.0/0" = module.nat.nat_id[0]
  }
}

module "public_subnet_associate" {
  source         = "./networking/subnet_associate"
  subnet_id      = module.public_subnet.subnet_id
  route_table_id = module.public_route_table.id
}

module "private_subnet_associate" {
  source         = "./networking/subnet_associate"
  subnet_id      = module.private_subnet.subnet_id
  route_table_id = module.private_route_table.id
}


module "key_pair" {
  source         = "./key_pair"
  key_name       = var.team_name
  tags           = var.tags
}

module "alb_security_group" {
  count          = var.enable_public_web_security_group_resource == true ? 1 : 0
  source         = "OT-CLOUD-KIT/security-groups/aws"
  version        = "2.0.0"
  name_sg        = "${var.team_name}-alb-sg"
  vpc_id         = module.vpc.vpc_id
  ingress_rule = {
    [
      description = "Rule for port 80"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    ],
    [
      description = "Rule for port 443"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    ]
  }
}

module "asg_security_group" {
  count   = var.enable_public_web_security_group_resource == true ? 1 : 0
  source  = "./security_group"
  name_sg = "${var.team_name}-asg-sg"
  vpc_id  = module.vpc.vpc_id
  ingress_rule = (
    {
      description  = "Rule for ALB on port 80"
      from_port    = 80
      to_port      = 80
      protocol     = "tcp"
      source_SG_ID = module.security_group[0].sg_id
    }
  )
}
module "launch_template" {
  source            = "./launch_template"
  lt_name           = var.team_name

  block_device_mappings = [{
    device_name     = "/dev/sdf"
    ebs             = {
      volume_size   = 8
    }
  }]
  placement_values = {
    availability_zone = format("%s-%s", local.region, elementvar.availability_zones, 0))
  }
  image_id                  = data.aws_ami.ubuntu.id
  user_data                 = templatefile("$path.module/userdata.sh" { team_name = var.team_name })
  tag_specifications = [{
    resource_type           = var.resource_type
    tags                    = var.tags
  }]
  network_interfaces  = [{
    subnet_id               = module.private_subnet.subnet_id
    security_groups         = [module.asg_security_group[0][0].sg_id]
  }]
  key_name                  = module.key_pair.key_pair_name
}

module "autoscaling_group" {
  source                     = "./autoscaling_group"
  asg_name                   = var.team_name
  launch_template_id         = module.launch_template.launch_template_id
  template_version           = module.launch_template.launch_template_latest_version
  vpc_zone_identifier_subnet = module.private_subnet.subnet_id
  max_size                   = var.max_size
  desired_size               = var.desired_size
  target_group_arns          = {[module.alb_target_group.target_group_arn]}
  extra_tags                  = [{
    key                 = "Name"
    value               = "${var.team_name}-ec2"
    propagate_at_launch = true
  }]
}


module "alb" {
  count = var.enable_pub_alb_resource == true ? 1 : 0
  source                     = "./load_balancer"
  alb_name                   = var.team_name
  internal                   = var.alb_type
  security_groups_id         = module.security_group[count.index].sg_id
  subnets_id                 = var.albtype == false module.public_subnet.subnet_id : []
  tags                       = var.tags
  enable_deletion_protection = var.enable_deletion_protection
  host_header_value          = [format("%s-leaf.%s", var.team_name , var.hosted_zone_name)]
  target_group_arn           = module.alb_target_group.arn
  alb_certificate_arn       =  data.aws_acm_certificate.arn
}

module "alb_target_group" {
  source                         = "./target_group"
  applicaton_name                = var.team_name
  vpc_id                         = module.vpc.vpc_id
}


module "route53_zone" {
  source                        = "git::https://github.com/OT-CLOUD-KIT/terraform-aws-route53-record-mapping.git?ref=route53"
  route53_record                = {
    format("%s-leaf.%s", var.team_name , var.hosted_zone_name) = {
      hosted_zone_name          = var.hosted_zone_name
      zone_id                   = data.aws_route53_zone.hostedzone.id
      type                      = var.route53_record_type
      ttl                       = null
      alias  = [
        name                   = module.alb[0].alb_dns_name
        zone_id                = module.alb[0].alb_zone
        evaluate_target_health = true
      ]
    }  
  }
}
